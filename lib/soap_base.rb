class SoapBase
  class << self
    def method_missing(method, *args, &block)
      body = args.last.is_a?(Hash) ? args.last : []
      p body
      make_request method, body
    end
  end

  def self.make_request method, body
    response = WSDLClient.request method, body: body
    resp = ActiveSupport::JSON.decode response.body.first[1].first[1] if response.success?
  end
end