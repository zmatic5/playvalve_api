require 'rails_helper'

RSpec.describe UserUpserterService do
  let(:user) { build(:user, ban_status: :allowed) }

  it 'updates and saves user' do
    expect(user).to receive(:ban_status=).with(:banned)
    expect(user).to receive(:save!).and_return(true)

    result = described_class.new(user: user, ban_status: :banned).call
    expect(result).to eq(user)
  end
end
