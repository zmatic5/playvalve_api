class IntegrityLogger
  def self.log(user:, ip:, rooted_device:, country:)
    IntegrityLog.create!(
      idfa: user.idfa,
      ban_status: user.ban_status,
      ip: ip,
      rooted_device: rooted_device,
      country: country,
      proxy: Rails.cache.fetch("vpnapi:#{ip}")&.dig("security", "proxy"),
      vpn: Rails.cache.fetch("vpnapi:#{ip}")&.dig("security", "vpn")
    )
  end
end
