# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'active_record/fixtures'
include ActiveRecord

fixtures_list = %w(specializations)

fixtures_list.each do |fixture|
  Fixtures.create_fixtures("#{Rails.root}/test/fixtures", fixture)
end

Admin.create email: 'admin@strona.pl', password: 'haslo'
DoctorUser.create email: 'doctor@strona.pl', password: 'haslo'
PatientUser.create email: 'patient@strona.pl', password: 'haslo'
