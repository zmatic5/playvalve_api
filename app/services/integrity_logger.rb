class IntegrityLogger
  def self.log(user:, ip:, rooted_device:, country:, vpn_data:)
    IntegrityLog.create!(
      idfa: user.idfa,
      ban_status: user.ban_status,
      ip: ip,
      rooted_device: rooted_device,
      country: country,
      proxy: vpn_data&.dig("proxy"),
      vpn: vpn_data&.dig("vpn")
    )
  end
end
