class PatientExt
  include SoapModel
  #attributes :id, :name, :surname, :clinic_id, :visit_duration, :created_at, :updated_at, :specialization_id
  crud :patient
end