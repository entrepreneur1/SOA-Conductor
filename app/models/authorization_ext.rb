class AuthorizationExt
  include SoapModel
  @soap_base = SoapBase.new(nil, 'http://clinic.hostingasp.pl/AuthenticationService.svc?wsdl')
  class << @soap_base
    def make_request method, body = ""
      request = client.request method do
        soap.version = 1
        soap.namespaces['xmlns:tem'] = "http://tempuri.org/"
        soap.namespaces['xmlns:aut'] = "http://schemas.datacontract.org/2004/07/AuthenticationService.DataContracts"
        soap.body = body #.to_xml.split("\n")[2..-2]
      end
      request.body.first[1].first[1]
    end
  end

  def self.authorize(login, password)
    @soap_base.make_request(:authorize, {'tem:authorizeRequest' => {"aut:Login" => login, "aut:Password" => password}})
  end

  def self.authorize_by_token
    @soap_base.make_request(:authorizeByToken, {'tem:authorizeByTokenRequest' => {"aut:Token" => "a", "aut:Username" => "B"}})
  end

  def self.register(login, password)
    @soap_base.make_request(:makeRegister, {'tem:registerRequest' => {"aut:Email" => login, "aut:Password" => password}})
  end

  def self.set_role(email, role)
    @soap_base.make_request(:set_role , {'tem:setRoleRequest' => {"aut:Email" => email, "aut:Type" => role}})
  end
end


