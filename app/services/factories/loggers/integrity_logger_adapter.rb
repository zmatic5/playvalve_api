# frozen_string_literal: true

module Factories
  module Loggers
    class IntegrityLoggerAdapter
      def log(user:, ip:, country:, rooted_device:)
        IntegrityLogger.log(
          user: user,
          ip: ip,
          country: country,
          rooted_device: rooted_device
        )
      end
    end
  end
end
