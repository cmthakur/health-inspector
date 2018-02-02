require 'yaml'
require 'erb'

class ServiceLoader
  attr_accessor :path, :services

  def initialize(args = {})
    @path = args.fetch('path', nil) || "#{Dir.pwd}/monitor.yml"
  end

  def configurations
    return {} unless File.exist?(@path)
    YAML.safe_load(ERB.new(File.read(@path)).result)
  end

  def services
    configurations.fetch('services', {})
  end

  def dependencies
    configurations.fetch('dependencies', {})
  end
end
