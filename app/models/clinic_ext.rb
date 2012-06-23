class ClinicExt
  include SoapModel
  @soap_base = SoapBase.new('http://soa.kacka.com.pl/')

  attributes :id, :name, :address_id, :created_at, :updated_at
  crud :clinic

  attr_accessor :address

  def initialize(json=nil)
    from_json(json) if json
    if json["address"]
      json_clinic = json["address"]
      json_clinic["id"]=json["address_id"]
      self.address = AddressExt.new(json_clinic)
    end
  end

  def self.all
    @soap_base.findClinics.map{|x| new(x)}
  end
end