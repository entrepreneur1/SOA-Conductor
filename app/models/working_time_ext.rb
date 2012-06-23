# encoding: utf-8
class WorkingTimeExt
  include SoapModel
  @soap_base = SoapBase.new('http://soa.marcinbiernat.pl/soap/')

  def self.workingHours(doctorId, date)
    t = @soap_base.getWorkingHours :doctorId => doctorId, :date => date.strftime("%Y-%m-%d")
    t["start"] = Time.parse(t["start"]).change(year: date.year, month: date.month, day: date.day)
    t["end"] = Time.parse(t["end"]).change(year: date.year, month: date.month, day: date.day)
    t["title"] = "Godziny pracy"
    t
  rescue
    nil
  end
end