class Rating < ActiveRecord::Base
  belongs_to :doctor
  validates_associated :doctor

  after_save { doctor.recalculate_rating }
end
