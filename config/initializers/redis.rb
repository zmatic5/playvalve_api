class RedisClient
  def self.instance
    @redis ||= Redis.new(url: ENV['REDIS_URL'] || 'redis://localhost:6379/1')
  end
end