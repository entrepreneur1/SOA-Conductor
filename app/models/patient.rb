class Patient < ActiveRecord::Base
  has_many :reservations
  belongs_to :patient_user, :foreign_key => :user_id
end
