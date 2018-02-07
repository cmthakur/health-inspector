RSpec.describe HealthInspector do
  describe '.version' do
    it 'current version 0.1.2' do
      expect(HealthInspector::VERSION).to eq '0.1.2'
    end
  end
end
