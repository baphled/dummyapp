require 'mongoid'

module QuikCV
  class Skillset
    include Mongoid::Document
    include Mongoid::Timestamps
    
    store_in :skillsets

    field :type
    field :skills
    
    belongs_to :profile, :class_name => 'QuikCV::Profile'
    
    validates_presence_of :type, :skills
    validates :type, :length => {:minimum => 3}
    validates :skills, :comma_separated_list_format => true
    
  end
end