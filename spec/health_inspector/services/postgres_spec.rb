require 'health_inspector/services/postgres'

class ConfigurationMissingError < StandardError; end

RSpec.describe HealthInspector::Services::Postgres do
  before do
    ENV['HEALTH_INSPECTOR_PATH'] = "#{Dir.pwd}/spec/fixtures/postgres_service.yml"
  end

  let(:postgres_service) { described_class.new }

  describe '#configuration' do
    subject { postgres_service.configuration }

    context 'inline service configuration provided' do
      context 'configs present' do
        it 'returns configuration' do
          expect(subject).to eq('adapter' => 'postgresql',
                                'host' => 'localhost',
                                'username' => 'postgres',
                                'database' => 'test_db',
                                'password' => nil)
        end
      end

      context 'configs missing' do
        it 'raise ConfigurationMissingError' do
          allow_any_instance_of(ServiceLoader).to receive(:path).and_return('')
          expect { subject }.to raise_error(HealthInspector::Services::Base::ConfigurationMissingError, 'No config provided for postgres')
        end
      end
    end
  end

  describe '#inspect!' do
    subject { postgres_service.inspect! }

    context 'database connection is successful' do
      before do
        connection = double(PG::Connection)
        allow(PG).to receive(:connect).and_return(connection)
        allow(connection).to receive(:close).and_return(true)
      end

      it 'returns status OK' do
        expect(subject).to eql(status: 'OK', timestamp: Time.now.utc.to_i)
      end
    end

    context 'database connection is not successful' do
      it 'returns status: FAILED' do
        pg_check = subject
        expect(pg_check[:status]).to eql('FAILED')
      end
    end
  end
end
