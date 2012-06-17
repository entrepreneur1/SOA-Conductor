class SoapBase
  class << self
    def method_missing(method, *args, &block)
      hash = args.last.is_a?(Hash) ? args.last : {}
      response = WSDLClient.request method, body: hash
      ActiveSupport::JSON.decode response.body.first[1].first[1] if response.success?
    end
  end
end