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
        begin
          con = PG.connect(:host => configuration[:hostname],
                           :port => configuration[:port],
                           :dbname => configuration[:database],
                           :user => configuration[:username],
                           :password => configuration[:password])
          return if con
        rescue
          raise DatabaseException.new("Could not connect to postgres") and return
        ensure
          con.close if con
        end
      end
    end
  end
end
