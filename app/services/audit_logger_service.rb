class AuditLoggerService
  def initialize(user:, ip:, country:, rooted_device:, vpn_data:)
    @user = user
    @ip = ip
    @country = country
    @rooted_device = rooted_device
    @vpn_data = vpn_data || {}
  end

  def call
    IntegrityLog.create!(
      idfa: user.idfa,
      ban_status: user.ban_status,
      ip: ip,
      country: country,
      rooted_device: rooted_device,
      vpn: vpn_data['vpn'],
      proxy: vpn_data['proxy']
    )
  end

  private

  attr_reader :user, :ip, :country, :rooted_device, :vpn_data
end
