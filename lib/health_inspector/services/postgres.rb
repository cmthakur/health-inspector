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
        con = PG.connect(host: configuration['hostname'],
                         port: configuration['port'] || 5432,
                         dbname: configuration['database'],
                         user: configuration['username'],
                         password: configuration['password'])

        return { status: 'OK' } if con
      rescue
        raise DatabaseException, 'Could not connect to postgres' && return
      ensure
        con.close if con
      end
    end
  end
end
