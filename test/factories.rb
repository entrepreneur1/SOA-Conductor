FactoryGirl.define do
  factory :doctor do
    name { Faker::Name.first_name }
    surname { Faker::Name.last_name }
    visit_duration { 5+Random.rand(30) }
  end
  
  factory :clinic do
    name { Faker::Company.name }
  end
end