require 'yaml'
require 'erb'

class ServiceLoader
  attr_accessor :path, :services

  def initialize(args = {})
    @path = args['path']
  end

  def monitor_configs
    @path ||= "#{Dir.pwd}/monitor.yml"
    YAML.safe_load(ERB.new(File.read(@path)).result)
  end

  def services
    monitor_configs.fetch('services', {})
  end

  def dependencies
    monitor_configs.fetch('dependencies', {})
  end
end
