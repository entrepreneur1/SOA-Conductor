FactoryGirl.define do
  factory :rating do
    comment { Faker::Lorem.sentences(2).join(" ") }
    rate { 1 + Random.rand(6)}
  end
end