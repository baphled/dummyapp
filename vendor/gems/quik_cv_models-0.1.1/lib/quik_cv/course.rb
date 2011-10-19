require 'mongoid'

module QuikCV
  class Course
    include Mongoid::Document
    include Mongoid::Timestamps

    store_in :courses
    
    field :title
    field :start_date, :type => Date
    field :end_date, :type => Date
    
    belongs_to :profile, :class_name => 'QuikCV::Profile'

    validates_presence_of :title, :start_date

    validates_date :end_date, :on_or_after => :start_date, :allow_blank => true
    validates_date :start_date, :on_or_before => :today

    def self.chronological
      desc :start_date
    end
  end
end
