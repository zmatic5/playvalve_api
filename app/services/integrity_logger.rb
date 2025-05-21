# frozen_string_literal: true

class IntegrityLogger
  def self.log(user:, ip:, rooted_device:, country:)
    vpn_data = Rails.cache.fetch("vpnapi:#{ip}")&.dig('security') || {}

    IntegrityLog.create!(
      idfa: user.idfa,
      ban_status: user.ban_status,
      ip: ip,
      rooted_device: rooted_device,
      country: country,
      proxy: vpn_data.fetch('proxy', false),
      vpn: vpn_data.fetch('vpn', false)
    )
  end
end
