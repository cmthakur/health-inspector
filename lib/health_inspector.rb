require 'health_inspector/version'
require 'health_inspector/service_loader'
require 'health_inspector/supervisor'

module HealthInspector
  extend self

  def load!
    services = ServiceLoader.new.services.keys
    services.each do |service|
      require "health_inspector/services/#{service}"
    end
  end

  def version
    VERSION
  end

  def inspect(services = nil)
    Supervisor.new(services).inspect
  end
end

HealthInspector.load!
