class ReservationExt
  include SoapModel
  @soap_base = SoapBase.new('http://soa.marcinbiernat.pl/soap/')

  def self.reservations(doctorId, date)
    t = @soap_base.getReservations :doctorId => doctorId, :date => date.strftime("%Y-%m-%d")
    t["start"] = Time.parse(t["start"])
    t["end"] = Time.parse(t["end"])
    t["title"] = "Rezerwacja"
    t
  rescue
    nil
  end
end