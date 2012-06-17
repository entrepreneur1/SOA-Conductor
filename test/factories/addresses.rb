FactoryGirl.define do
  factory :address do
    street { Faker::Address.street_name }
    city { Faker::Address.city }
    number { 1+Random.rand(50) }
    postcode { Faker::Address.postcode }
  end
end
