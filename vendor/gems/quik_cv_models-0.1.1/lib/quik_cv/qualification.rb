require 'mongoid'
require 'validates_timeliness'

module QuikCV
  class Qualification
    include Mongoid::Document
    include Mongoid::Timestamps

    store_in :qualifications
    
    field :place
    field :course
    field :start_date, :type => Date
    field :end_date, :type => Date
    
    belongs_to :profile, :class_name => 'QuikCV::Profile'
    
    validates_presence_of :place, :course
    
    validates_date :end_date, :on_or_after => :start_date, :allow_blank => true
    validates_date :start_date, :on_or_before => :today

    def self.chronological
      desc :start_date
    end
  end
end
