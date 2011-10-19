module QuikCV
  class User
    include Mongoid::Document
    include Mongoid::Timestamps

    store_in :users

    field :username
    field :email
    
    has_one :profile, autosave: true, :class_name => 'QuikCV::Profile'
    
    accepts_nested_attributes_for :profile
    
    validates_presence_of :username, :profile, :email
    validates_uniqueness_of :username

    # @TODO Move all personal information into this class
    def full_name
      "#{profile.first_name} #{profile.last_name}" unless self.profile.nil?
    end

    def has_profile?
      self.profile.present?
    end

    def personal_info?
      (self.profile.first_name.blank? and self.profile.last_name.blank? and self.profile.contact_number.blank?)? false : true
    end
    
    def to_json options = {}
      super(:include => {:profile =>{:include => [:entries, :experiences, :qualifications, :courses, :skillsets]}})
    end
  end
end
