require 'health_inspector/services/hutch'
require 'pry'

class ConfigurationMissingError < StandardError; end

RSpec.describe HealthInspector::Services::Hutch do
  before do
    ENV['HEALTH_INSPECTOR_PATH'] = "#{Dir.pwd}/spec/fixtures/hutch_service.yml"
  end

  let(:hutch_service) { described_class.new }

  let(:config_params) do
    {
      'mq_host' => '127.0.0.1',
      'mq_api_host' => '127.0.0.1',
      'mq_vhost' => '/',
      'mq_api_port' => 15672,
      'mq_port' => 5672,
      'mq_username' => 'guest',
      'mq_password' => 'guest'
    }
  end

  describe '#configuration' do
    subject { hutch_service.configuration }

    context 'inline service configuration provided' do
      context 'configs present' do
        it 'returns configuration' do
          expect(subject).to eq(config_params)
        end
      end

      context 'configs missing' do
        it 'raise ConfigurationMissingError' do
          allow_any_instance_of(ServiceLoader).to receive(:path).and_return('')
          expect { subject }.to raise_error(HealthInspector::Services::Base::ConfigurationMissingError, 'No config provided for hutch')
        end
      end
    end
  end

  describe '#inspect!' do
    subject { hutch_service.inspect! }

    context 'hutch connection is successful' do
      before do
        connection = double(::Hutch.connect)
        allow(::Hutch).to receive(:connected?).and_return(connection)
      end

      it 'returns status OK' do
        expect(subject).to eql(status: 'OK', timestamp: Time.now.utc.to_i)
      end
    end

    context 'hutch connection is not successful' do
      it 'returns status: FAILED' do
        hutch_check = subject
        expect(hutch_check[:status]).to eql('FAILED')
      end
    end
  end
end
