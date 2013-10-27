require File.expand_path("../db_config", __FILE__)
require 'cache_translated_attribute'

begin
  require 'globalize'
rescue MissingSourceFile
  puts "This plugin requires the globalize3 gem"
  puts
  raise
end
# models
class Hotel < ActiveRecord::Base
  attr_accessible :name, :description
  translates :name, :description

  cache_translated_attribute :name
  has_many :rooms, dependent: :destroy
end

class Room < ActiveRecord::Base
  attr_accessible :hotel_id, :title

  translates :title
  cache_translated_attribute :title
  belongs_to :hotel

end

#migrations
class CreateAllTables < ActiveRecord::Migration
  def self.up
    create_table(:hotels) { |t| t.boolean :active }
    create_table(:rooms) { |t| t.integer :hotel_id }
    Hotel.create_translation_table! name: :string, description: :text
    Room.create_translation_table! title: :string
  end
end

ActiveRecord::Migration.verbose = false
CreateAllTables.up