require 'spec_helper'
require File.expand_path("../../supports/active_record/models", __FILE__)

describe 'Cache Translated Attribute' do
  before(:each) do
    Hotel.destroy_all
    I18n.locale = :en
    @hotel = Hotel.create(name: 'hotel name', description: 'hotel description1')
    I18n.locale = :ar
    @hotel.name = 'ar hotel name '
    @hotel.description = 'ar description '
    @hotel.save

    @room1 = @hotel.rooms.create(title: 'room title ar 1')
    @room2 = @hotel.rooms.create(title: 'room title ar 2')
    I18n.locale = :en
    @room1.update_attributes(title: 'room title en 1')
    @room2.update_attributes(title: 'room title en 2')
  end

  context 'cached methods' do
    it 'should create cache key and expires properly' do
      Rails.cache.delete_matched @hotel.translated_all_cache_key
      @hotel.update_attributes(name: 'new name')
      expect(Rails.cache.read([@hotel.class.name, :translated_attribute, @hotel.id, :name, I18n.locale])).to eq 'new name'
      @hotel.update_attributes(name: 'new name2')
      expect(Rails.cache.read([@hotel.class.name, :translated_attribute, @hotel.id, :name, I18n.locale])).to eq 'new name2'
    end

    it 'should delete cache key on delete' do
      Rails.cache.delete_matched @hotel.translated_all_cache_key
      @hotel.update_attributes(name: 'new name')
      expect(Rails.cache.read([@hotel.class.name, :translated_attribute, @hotel.id, :name, I18n.locale])).to eq 'new name'
      delete_class_name = @hotel.class.name
      delete_id = @hotel.id
      @hotel.destroy
      expect(Rails.cache.read([delete_class_name, :translated_attribute, delete_id, :name, I18n.locale])).to be_nil
    end
  end
end