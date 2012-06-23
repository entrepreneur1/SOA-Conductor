require 'builder'

class DoctorExt
  include SoapModel
  @soap_base = SoapBase.new('http://soa.kacka.com.pl/')
  attributes :id, :name, :surname, :clinic_id, :visit_duration, :created_at, :updated_at, :specialization_id
  crud :doctor

  attr_accessor :clinic

  def self.addClinics(doctors)
    clinics = doctors.map(&:clinic_id).uniq.inject({}) { |hash, clinic_id|
      hash[clinic_id] = ClinicExt.find(clinic_id.to_i)
      hash
    }
    doctors.each do |doctor|
      doctor.clinic = clinics[doctor.clinic_id]
    end
    doctors

  end

  def full_name
    "#{name} #{surname}"
  end

  def self.all(query = nil)

    if query
      builder = Builder::XmlMarkup.new
      xml = builder.query(query.to_json.to_s)
      query = xml.to_s
    else
      query = ""
    end

    @soap_base.findDoctors(query).map { |x| new(x) }
  end


  def self.count(query = {})
    query["count"] = true
    builder = Builder::XmlMarkup.new
    xml = builder.query(query.to_json.to_s)
    query = xml.to_s
    @soap_base.findDoctors(query).first["count"].to_i
  end



end