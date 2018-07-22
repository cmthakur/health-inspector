require 'health_inspector/services/base'
require 'hutch'

module HealthInspector
  module Services
    class HutchException < StandardError; end

    class Hutch < Base
      attr_accessor :configuration

      def initialize
        super
      end

      def self.slug
        'hutch'
      end

      def inspect!
        ::Hutch::Config.initialize(configuration)
        ::Hutch.connect
        return { status: 'OK', timestamp: Time.now.utc.to_i } if ::Hutch.connected?
      rescue StandardError => e
        { status: 'FAILED',
          message: "Could not connect to hutch. Error: #{e.inspect}",
          timestamp: Time.now.utc.to_i }
      ensure
        ::Hutch.disconnect
      end
    end
  end
end
