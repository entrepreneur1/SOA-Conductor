namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    25.times do
      clinic = FactoryGirl.build(:clinic)
      clinic.address = FactoryGirl.build(:address)
      (10+Random.rand(20)).times do
        doctor =  clinic.doctors.build(FactoryGirl.attributes_for(:doctor, specialization: Specialization.find(Random.rand(Specialization.all.size) + 1)))
        (1+Random.rand(5)).times do
          doctor.reservations.build(FactoryGirl.attributes_for(:reservation))
        end
        (1+Random.rand(4)).times do
          doctor.ratings.build(FactoryGirl.attributes_for(:rating))
        end
        (0..6).each do |i|
          doctor.working_times.build(FactoryGirl.attributes_for(:working_time, day: i))
        end
      end
      clinic.save(validate: false)
    end
  end
end