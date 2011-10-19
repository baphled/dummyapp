module QuikCV
  class Experience
    include Mongoid::Document
    include Mongoid::Timestamps

    store_in :experiences
    
    field :role
    field :description
    field :start_date, :type => Date
    field :end_date, :type => Date
    field :is_corporate, :default => true
    field :company_name
    field :company_link, :type => String
    field :company_description
    field :skills, :type => String, :default => nil
    
    belongs_to :profile, :class_name => 'QuikCV::Profile'
    
    validates_presence_of :role, :description, :start_date

    validates_date :start_date, :on_or_before => :today
    validates_date :end_date, :on_or_after => :start_date, :allow_blank => true

    validates :company_name,
      :presence => true,
      :length => {:minimum => 2}
    validates :skills, :comma_separated_list_format => true

    def self.chronological
      desc :start_date
    end
  end
end