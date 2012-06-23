class PatientExt
  include SoapModel
  @soap_base = SoapBase.new('http://soa.kacka.com.pl/')
  #attributes :id, :name, :surname, :clinic_id, :visit_duration, :created_at, :updated_at, :specialization_id
  crud :patient
end