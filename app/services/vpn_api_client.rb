class VpnApiClient
  BASE_URL = 'https://vpnapi.io/api'

  def self.check(ip)
    Rails.cache.fetch("vpnapi:#{ip}", expires_in: 24.hours) do
      response = HTTParty.get("#{BASE_URL}/#{ip}?key=#{ENV['VPNAPI_API_KEY']}")
      if response.success?
        JSON.parse(response.body)
      else
        {}
      end
    end
  rescue => e
    Rails.logger.warn("VPN API check failed: #{e.message}")
    {}
  end
end
