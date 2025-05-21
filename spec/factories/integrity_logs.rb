FactoryBot.define do
  factory :integrity_log do
    idfa { SecureRandom.uuid }
    ban_status { :allowed }
    ip { '127.0.0.1' }
    country { 'US' }
    rooted_device { false }
    vpn { false }
    proxy { false }
  end
end
