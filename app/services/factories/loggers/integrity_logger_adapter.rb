module Factories
  module Loggers
    class IntegrityLoggerAdapter
      def log(user)
        IntegrityLogger.log(
          user: user,
          ip: Current.ip,
          country: Current.country,
          rooted_device: Current.rooted_device,
          vpn_data: Current.vpn_data
        )
      end
    end
  end
end
