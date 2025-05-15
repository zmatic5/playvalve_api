class VpnApiClient
  base_uri 'https://vpnapi.io/api'

  def self.check(ip)
    cache_key = "vpnapi:#{ip}"
    cached = RedisClient.instance.get(cache_key)
    return JSON.parse(cached) if cached

    response = get("/#{ip}?key=#{ENV['VPNAPI_KEY']}")
    if response.success?
      RedisClient.instance.setex(cache_key, 24.hours.to_i, response.body)
      JSON.parse(response.body)
    else
      {}
    end
  rescue => e
    Rails.logger.warn("VPN API check failed: #{e.message}")
    {}
  end
end
