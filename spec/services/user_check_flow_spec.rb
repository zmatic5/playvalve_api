# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserCheckFlow do
  let(:user) { User.new(idfa: 'abc', ban_status: :allowed) }

  before do
    allow(User).to receive(:find_or_initialize_by).and_return(user)
    allow(VpnApiClient).to receive(:check).and_return({ 'security' => { 'vpn' => false } })
    allow(Rails.cache).to receive(:fetch).and_return(['US'])
    allow(user).to receive(:save!).and_return(true)
    allow(user).to receive(:saved_change_to_ban_status?).and_return(true)
    allow(user).to receive(:saved_change_to_id?).and_return(false)
    allow_any_instance_of(Factories::Loggers::IntegrityLoggerAdapter).to receive(:log)
  end

  it 'calls services and returns user' do
    result = described_class.new(
      idfa: 'abc',
      rooted_device: false,
      ip: '1.1.1.1',
      country: 'US'
    ).call

    expect(result).to be_a(User)
  end
end
