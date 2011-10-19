FactoryGirl.define do
  factory :profile, :class => QuikCV::Profile do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    contact_number '0207 444 4444'
    mobile_number '07890 098 0987'
    profession 'Programmer'
  end

  factory :experience, :class => QuikCV::Experience do |f|
    f.company_name { Faker::Lorem.words(2).join('  ') }
    f.company_description { Faker::Lorem.sentence(1) }
    f.role { Faker::Lorem.words(1).join('  ') }
    f.description { Faker::Lorem.sentence(4) }
    profile { FactoryGirl.create(:profile) }
    f.start_date { Date.yesterday }
  end

  factory :course, :class => QuikCV::Course do |f|
    f.title { Faker::Lorem.words(2).join(' ') }
    f.start_date { Date.yesterday }
  end

  factory :qualification, :class => QuikCV::Qualification do |f|
    f.place { Faker::Lorem.words(3).join(' ') }
    f.course { Faker::Lorem.sentence(1) }
    f.start_date { Date.yesterday }
    profile { FactoryGirl.create(:profile) }
  end

end
