class ReservationExt
  include SoapModel
  @soap_base = SoapBase.new('http://soa.marcinbiernat.pl/soap/')

  def self.reservations(doctorId, date)
    times = @soap_base.getReservations :doctorId => doctorId, :date => date.strftime("%Y-%m-%d")
    times.map! do |t|
      t["start"] = Time.parse(t["start"])
      t["end"] = Time.parse(t["end"])
      t["title"] = "Rezerwacja"
      t
    end
    times
  rescue
    nil
  end

  def self.reserve(doctorId, patientId, dateFrom, dateTo)
    format = "%Y-%m-%dT%T"
    @soap_base.make_request :reserve, :doctorId => doctorId, :patientId => patientId, :dateFrom => dateFrom.strftime(format), :dateTo => dateTo.strftime(format)
  end

  def self.cancelReservation(id)
    @soap_base.cancelReservation :reservationId => id
  end

  def self.getReservationsByPatient(id)
    @soap_base.getReservationsByPatient :patientId => id
  end
end