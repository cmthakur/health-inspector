require 'health_inspector/services/base'
require 'pg'

module HealthInspector
  module Services
    class DatabaseException < StandardError; end

    class Postgres < Base
      attr_accessor :configuration

      def initialize
        super
      end

      def self.slug
        'postgres'
      end

      def inspect!
        connection = PG.connect(host: configuration['hostname'],
                                port: configuration['port'] || 5432,
                                dbname: configuration['database'],
                                user: configuration['username'],
                                password: configuration['password'])

        return { status: 'OK', timestamp: Time.now.utc.to_i } if connection
      rescue StandardError => e
        { status: 'FAILED',
          message: "Could not connect to postgres. Error: #{e.inspect}",
          timestamp: Time.now.utc.to_i }
      ensure
        connection.close if connection
      end
    end
  end
end
