class SoapBase

  def initialize(endpoint,wsdl = nil)
    wsdl ||= Rails.root.join('config','wsdl','soa.wsdl').to_s
    @client = Savon::Client.new(wsdl)
    @client.wsdl.endpoint = URI(endpoint) if endpoint
  end

  def client
    @client
  end

    def method_missing(method, *args, &block)
      body = args.last
      make_request method, body
    end

  def make_request method, body = ""
    response = @client.request method, body: body
    resp = ActiveSupport::JSON.decode response.body.first[1].first[1] if response.success?
  end
end