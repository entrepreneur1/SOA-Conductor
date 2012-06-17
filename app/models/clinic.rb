class Clinic < ActiveRecord::Base
  has_many :doctors
  has_one :address
end
