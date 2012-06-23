class ReservationExt
  include SoapModel
  @soap_base = SoapBase.new('http://soa.marcinbiernat.pl/soap/')

end