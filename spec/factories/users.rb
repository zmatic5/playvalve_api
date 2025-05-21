# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    idfa { SecureRandom.uuid }
    ban_status { :allowed }
  end
end
