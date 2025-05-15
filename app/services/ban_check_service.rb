class BanCheckService
  def initialize(idfa:, rooted_device:, ip:, country:)
    @idfa = idfa
    @rooted_device = rooted_device
    @ip = ip
    @country = country
  end

  def call
    user = User.find_or_initialize_by(idfa: @idfa)

    if user.persisted? && user.ban_status == :banned
      return user
    end

    banned = rooted_check? || country_check? || vpn_check?
    old_status = user.ban_status

    user.ban_status = banned ? :banned : :not_banned
    user.save!

    if user.new_record? || old_status != user.ban_status
      IntegrityLogger.log(
        user: user,
        ip: @ip,
        rooted_device: @rooted_device,
        country: @country,
        vpn_data: @vpn_data
      )
    end

    user
  end

  private

  def rooted_check?
    @rooted_device
  end

  def country_check?
    whitelist = RedisClient.instance.smembers('country_whitelist')
    !whitelist.include?(@country)
  end

  def vpn_check?
    @vpn_data = VpnApiClient.check(@ip) || {}
    security = @vpn_data["security"] || {}
    security["vpn"] || security["proxy"] || security["tor"]
  end
end
