RSpec.describe ServiceLoader do
  let(:args) { { 'path' => 'spec/fixtures/monitor.yml' } }
  let(:service_loader) { ServiceLoader.new(args) }

  describe '#configurations' do
    subject { service_loader.configurations }

    context 'with default config path' do
      let(:args) { {} }

      it 'reads configs from current directory monitor.yml' do
        expect(subject).not_to be_empty
      end
    end

    context 'with user defined config path' do
      context 'path exists' do
        it 'reads configs from provided path' do
          expect(subject).not_to be_empty
        end
      end

      context 'path does not exists' do
        let(:args) { { 'path' => 'config.yml' } }

        it 'returns blank configurations ' do
          expect(subject).to eq({})
        end
      end
    end
  end

  describe '#services' do
    subject { service_loader.services }

    it 'list all services mentioned in config path' do
      expect(subject).to eq('postgres' => {
                              'name' => 'PostgreSql',
                              'config' => { 'adapter' => 'postgresql' }
                            })
    end
  end

  describe '#dependencies' do
    subject { service_loader.dependencies }

    it 'list all dependent gems mentioned in config path' do
      expect(subject).to eq(['pg'])
    end
  end
end
