class DoctorExt
  include SoapModel
  @soap_base = SoapBase.new('http://soa.kacka.com.pl/')
  attributes :id, :name, :surname, :clinic_id, :visit_duration, :created_at, :updated_at, :specialization_id
  crud :doctor

  def self.all
    p "Baza: #{@soap_base.inspect}"
    @soap_base.send "findDoctors"
  end

end