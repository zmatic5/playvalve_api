class BanCheckService
  def initialize(idfa:, rooted_device:, ip:, country:)
    @idfa = idfa
    @rooted_device = rooted_device
    @ip = ip
    @country = country
  end

  def call
    user = User.find_or_initialize_by(idfa: idfa)

    return user if user.persisted? && user.banned?

    user.ban_status = should_ban? ? :banned : :allowed
    user.save!
    user
  end

  private

  attr_reader :ip, :country, :idfa, :rooted_device, :vpn_data

  def should_ban?
    rooted_check? || country_check? || vpn_check?
  end

  def rooted_check?
    rooted_device
  end

  def country_check?
    whitelist = Rails.cache.fetch('country_whitelist') { [] }
    !whitelist.include?(country)
  end

  def vpn_check?
    vpn_data = VpnApiClient.check(ip) || {}
    security = vpn_data["security"] || {}
    Current.vpn_data = security
    security["vpn"] || security["proxy"] || security["tor"]
  end
end
