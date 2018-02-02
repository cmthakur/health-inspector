require 'yaml'
require 'erb'

class ServiceLoader
  attr_accessor :path

  def initialize
    @path = ENV['HEALTH_INSPECTOR_PATH'] || "#{Dir.pwd}/monitor.yml"
  end

  class << self
    def configurations
      loader = new
      return {} unless File.exist?(loader.path)
      YAML.safe_load(ERB.new(File.read(loader.path)).result)
    end

    def services
      configurations.fetch('services', {})
    end

    def dependencies
      configurations.fetch('dependencies', {})
    end
  end
end
