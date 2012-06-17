FactoryGirl.define do
  factory :reservation do |f|
    f.start { DateTime.current + Random.rand(5).hours }
    f.end { start + 25.minutes + Random.rand(35).minutes }
  end
end