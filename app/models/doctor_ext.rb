class DoctorExt
  def self.find(id)
    response = WSDLClient.request 'getDoctor', body: {:doctorId => id }
    ActiveSupport::JSON.decode response.body.first[1].first[1]
  end
end