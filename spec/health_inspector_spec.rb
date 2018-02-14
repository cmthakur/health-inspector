RSpec.describe HealthInspector do
  describe '.version' do
    it 'current version 0.1.3' do
      expect(HealthInspector::VERSION).to eq '0.1.3'
    end
  end
end
