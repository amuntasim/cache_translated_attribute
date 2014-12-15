require "cache_translated_attribute/version"
require 'active_support'

module CacheTranslatedAttribute
  module CacheKeyInstanceMethods
    def translated_cache_key(field)
      "#{self.class.name}/translated_attribute/#{self.id}/#{field}/#{I18n.locale}"
    end

    def translated_partial_cache_key(field)
      "#{self.class.name}/translated_attribute/#{self.id}/#{field}*"
    end

    def translated_all_cache_key
      "#{self.class.name}/translated_attribute/#{self.id}*"
    end
  end

  module ClassMethods

    def cache_translated_attribute(*attributes)
      include CacheKeyInstanceMethods
      options = attributes.extract_options!
      attributes = attributes.collect(&:to_sym)
      options.symbolize_keys!

      attributes.each do |cacheable|
        define_method "_#{cacheable}" do
          Rails.cache.fetch(translated_cache_key(cacheable)) do
            self.read_attribute cacheable, locale: I18n.locale
          end
        end
      end

      after_save do
        affected_attributes = changed_attributes.symbolize_keys.keys & attributes
        affected_attributes.each do |attr|
          Rails.cache.delete_matched translated_partial_cache_key(attr)
        end
      end

      before_destroy do
        Rails.cache.delete_matched translated_all_cache_key
      end
    end
  end

  def self.included(receiver)
    receiver.extend ClassMethods
  end
end

ActiveSupport.on_load(:active_record) do
  include CacheTranslatedAttribute
end
