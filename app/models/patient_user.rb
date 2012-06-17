class PatientUser < User
  has_one :patient, :foreign_key => :user_id
  attr_accessible :email, :password, :password_confirmation, :patient_attributes, :patient
  accepts_nested_attributes_for :patient
end