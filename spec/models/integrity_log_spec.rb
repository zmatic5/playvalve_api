# frozen_string_literal: true

require 'rails_helper'

RSpec.describe IntegrityLog, type: :model do
  subject { build(:integrity_log) }

  it { should validate_presence_of(:ban_status) }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end
end
