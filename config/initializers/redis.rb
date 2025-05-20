Rails.application.config.cache_store = :redis_cache_store, {
  url: ENV['REDIS_URL'] || 'redis://localhost:6379/1'
}
