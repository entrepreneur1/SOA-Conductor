class AddressExt
  include SoapModel
  @soap_base = SoapBase.new('http://soa.kacka.com.pl/')
  attributes :id, :street, :city, :number, :postcode
  crud :address

end

