module QuikCV
  class Profile
    include Mongoid::Document
    include Mongoid::Timestamps

    store_in :profiles

    field :first_name
    field :last_name
    field :contact_number
    field :mobile_number
    field :profession
    field :dob, :type => Date
    field :availability, :type => Date
    
    validates_presence_of :first_name, :last_name
    
    validates :dob, :is_date_format => true, :allow_blank => true
    validates :availability, :is_date_format => true, :allow_blank => true
    validates_associated :experiences, :skillsets, :entries, :qualifications, :courses

    # Entries associated to the profile
    has_many :experiences, :dependent => :destroy , :autosave => true, :class_name => 'QuikCV::Experience'
    has_many :skillsets, :dependent => :destroy , :autosave => true, :class_name => 'QuikCV::Skillset'
    has_many :entries, :dependent => :destroy , :autosave => true, :class_name => 'QuikCV::Entry'
    has_many :qualifications, :dependent => :destroy , :autosave => true, :class_name => 'QuikCV::Qualification'
    has_many :courses, :dependent => :destroy , :autosave => true, :class_name => 'QuikCV::Course'
    
    belongs_to :user, :class_name => 'QuikCV::User'
    
    accepts_nested_attributes_for :experiences, :skillsets, :entries, :qualifications, :courses
    
    def has_entries?
      jobs_or_qualifications = (self.experiences.count >= 1 or self.qualifications.count >= 1)
      personal_statement_or_skillsets = (self.entries.count >= 1 and self.skillsets.count >= 3)
      (jobs_or_qualifications and personal_statement_or_skillsets)? true : false
    end
  end
end