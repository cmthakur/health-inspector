class Supervisor
  attr_accessor :services

  def initialize
    @services = ServiceLoader.services
  end

  def inspect
    @services.each_with_object({}) do |(service_name, _config), status_check|
      service_klass = Object.const_get("HealthInspector::Services::#{service_name.capitalize}")
      status_check[service_klass.slug] = service_klass.new.inspect!
    end
  end
end
