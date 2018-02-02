module HealthInspector
  module Services
    class Base
      class ConfigurationMissingError < StandardError; end

      attr_accessor :configuration

      def initialize
        service_name = self.class.slug
        config_data = ServiceLoader.services.fetch(service_name, {})
        config_path = config_data.fetch('config_path', nil)
        configs = config_data.fetch('config', {})

        @configuration = if !configs.empty?
                           configs
                         elsif !config_path.nil?
                           config_full_path = "#{Dir.pwd}/#{config_path}"
                           if File.exist?(config_full_path)
                             YAML.safe_load(ERB.new(File.read(@path)).result)
                           end
        end

        if @configuration.empty? || !@configuration.is_a?(Hash)
          raise ConfigurationMissingError, "No config provided for #{service_name}"
        end
      end

      def self.slug
        to_s.split('::').last.downcase
      end

      def inspect!
        raise NotImplementedError
      end
    end
  end
end
