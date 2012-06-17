class DoctorUser < User
  has_one :doctor, :foreign_key => 'user_id'
end