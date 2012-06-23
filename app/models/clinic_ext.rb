class ClinicExt
  include SoapModel
  @soap_base = SoapBase.new('http://soa.kacka.com.pl/')

  attributes :id, :name, :address_id, :created_at, :updated_at
  crud :clinic
end