module SoapModel
  def self.included(base)
    base.extend(ClassMethods)
  end

  ATTRIBUTES = []

  def initialize(json=nil)
    p json
    from_json(json) if json
  end

  module ClassMethods
    def attributes(*args)
      ATTRIBUTES.concat(args.map(&:to_s))
      args.each do |attr|
        attr_accessor attr
      end
    end

    def crud(model_name, options = {})
      model_name = model_name.to_s.camelize
      excepts = options[:except].map(&:to_sym) if options[:except]
      excepts ||= []
      define_singleton_method "find" do |id|
        new(SoapBase.send "get#{model_name}", "#{model_name.downcase}Id" => id)
      end unless excepts.include?(:get)

      define_singleton_method "all" do
        SoapBase.send "get#{model_name.pluralize}"
      end unless excepts.include?(:remove)

      define_singleton_method "update" do
        new(SoapBase.send "update#{model_name}", soap_json)
      end unless excepts.include?(:update)

      define_singleton_method "create" do |options|
        new(SoapBase.send "add#{model_name}", options)
      end unless excepts.include?(:create)

      define_singleton_method "delete" do |options|
        id = (options if options.is_a?(Integer)) or (options[:id] or options['id'] if options.is_a(Hash))
        SoapBase.send "remove#{model_name}", "#{model_name.downcase}Id" => id
      end unless excepts.include?(:remove)
    end
  end

  def from_json(json)
    ATTRIBUTES.each do |attr|
      if value = json[attr]
        send "#{attr}=", value
      end
    end
  end

  def to_json(options = {})
    data = as_json
    raise ArgumentError "Except and only can't be used together" if options[:except] && options[:only]
    if options[:except]
      Array(options[:except]).each { |o| data.delete o }
    end
    if options[:only]
      onlys = Array(options[:only]).map(&:to_s)
      data.select! { |key, _| onlys.include?(key.to_s) }
    end
    data
  end

  def soap_json(options = {})
    to_json({:except => ['created_at', 'updated_at']}.merge(options))
  end
end