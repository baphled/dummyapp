require 'mongoid'

module QuikCV
  class Entry
    include Mongoid::Document
    include Mongoid::Timestamps

    store_in :entries
    
    field :title
    field :content

    belongs_to :profile, :class_name => 'QuikCV::Profile'
    
    validates_presence_of :title, :content
  end
end