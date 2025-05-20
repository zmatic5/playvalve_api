require 'net/http'
require 'uri'
require 'json'

class VpnApiClient
  BASE_URL = 'https://vpnapi.io/api'

  def self.check(ip)
    Rails.cache.fetch("vpnapi:#{ip}", expires_in: 24.hours) do
      response = request(ip)
      parse(response)
    end
  rescue => e
    Rails.logger.warn("VPN API check failed for #{ip}: #{e.message}")
    {}
  end

  private

  def self.request(ip)
    uri = URI("#{BASE_URL}/#{ip}?key=#{ENV['VPNAPI_API_KEY']}")
    Net::HTTP.get_response(uri)
  end

  def self.parse(response)
    return {} unless response.is_a?(Net::HTTPSuccess)

    JSON.parse(response.body)
  rescue JSON::ParserError => e
    Rails.logger.warn("VPN API JSON parse error: #{e.message}")
    {}
  end
end
