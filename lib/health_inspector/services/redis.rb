require 'health_inspector/services/base'
require 'redis'

module HealthInspector
  module Services
    class RedisException < StandardError; end

    class Redis < Base
      attr_accessor :configuration

      def initialize
        super
      end

      def self.slug
        'redis'
      end

      def redis_configuration
        redis_configs = {
          'host' => configuration['host'],
          'password' => configuration['password'],
          'port' => (configuration['port'] || 6379),
          'db' => (configuration['db'] || 1)
        }

        sentinels = configuration['sentinels']
        if !sentinels.nil? && sentinels.present?
          redis_configs['sentinels'] = configuration['sentinels']
          redis_configs['role'] = configuration['role']
          redis_configs['host'] = configuration['master_name']
        end

        redis_configs[:url] = "redis://#{configuration['host']}"
        redis_configs
      end

      def inspect!
        redis_connection = ::Redis.new(redis_configuration)
        redis_connection.set('health_monitor_redis', 'added')
        redis_connection.del('health_monitor_redis')

        return { status: 'OK', timestamp: Time.now.utc.to_i } if redis_connection
      rescue => e
        raise RedisException, "Could not connect to redis-server. Error: #{e.inspect}" && return
      ensure
        redis_connection.disconnect! if redis_connection
      end
    end
  end
end
