class BanEvaluatorService
  attr_reader :vpn_data

  def initialize(rooted_device:, ip:, country:)
    @rooted_device = rooted_device
    @ip = ip
    @country = country
    @vpn_data = {}
  end

  def banned?
    rooted_check? || country_check? || vpn_check?
  end

  private

  attr_reader :ip, :country, :rooted_device

  def rooted_check?
    rooted_device
  end

  def country_check?
    whitelist = Rails.cache.fetch('country_whitelist') { [] }
    !whitelist.map(&:upcase).include?(country.to_s.upcase)
  end

  def vpn_check?
    response = VpnApiClient.check(ip)
    @vpn_data = response['security'] || {}
    @vpn_data['vpn'] || @vpn_data['proxy'] || @vpn_data['tor']
  rescue
    false
  end
end
