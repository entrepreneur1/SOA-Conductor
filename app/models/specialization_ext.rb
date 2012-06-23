class SpecializationExt
  include SoapModel
  @soap_base = SoapBase.new('http://soa.kacka.com.pl/')
  attributes :id, :name, :description, :created_at, :updated_at

  def self.all
    @soap_base.getSpecializations.map{|x| new(x)}
  end
end