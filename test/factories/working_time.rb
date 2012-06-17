FactoryGirl.define do
  factory :working_time do |f|
    f.start { Time.current - 1 - Random.rand(4).hours }
    f.end { Time.current + 1 + Random.rand(5).hours }
  end
end