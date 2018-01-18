require 'health_monitor/version'
require 'health_monitor/service_loader'
require 'health_monitor/supervisor'

module HealthMonitor
  extend self

  def load!
    services = ServiceLoader.new.services.keys
    services.each do |service|
      require "health_monitor/services/#{service}"
    end
  end

  def version
    VERSION
  end

  def check(services = nil)
    Supervisor.new(services).check
  end
end

HealthMonitor.load!
