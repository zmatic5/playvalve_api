require 'rails_helper'

RSpec.describe BanEvaluatorService do
  before do
    allow(Rails.cache).to receive(:fetch).and_return(['US'])
    allow(VpnApiClient).to receive(:check).and_return({ 'security' => { 'vpn' => false } })
  end

  it 'returns false when checks pass' do
    evaluator = described_class.new(rooted_device: false, ip: '1.1.1.1', country: 'US')
    expect(evaluator.banned?).to be false
  end

  it 'returns true when rooted_device is true' do
    evaluator = described_class.new(rooted_device: true, ip: '1.1.1.1', country: 'US')
    expect(evaluator.banned?).to be true
  end

  it 'returns true when country is not in whitelist' do
    allow(Rails.cache).to receive(:fetch).and_return(['HR'])
    evaluator = described_class.new(rooted_device: false, ip: '1.1.1.1', country: 'RU')
    expect(evaluator.banned?).to be true
  end
end
