require 'health_inspector/version'
require 'health_inspector/service_loader'
require 'health_inspector/supervisor'

module HealthInspector
  class ConfigurationMissingError < StandardError; end

  extend self

  def load_services!
    services = ServiceLoader.services.keys
    services.each do |service|
      require "health_inspector/services/#{service}"
    end
  end

  def version
    VERSION
  end

  def inspect!(services = nil)
    load_services!

    unless File.exist?(ServiceLoader.new.path)
      raise(ConfigurationMissingError, 'Configuration file not found') && return
    end
    Supervisor.new(services).inspect!
  end
end
