require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  it { should validate_presence_of(:idfa) }
  it { should validate_uniqueness_of(:idfa) }
  it { should validate_presence_of(:ban_status) }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end
end
