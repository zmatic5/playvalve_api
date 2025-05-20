module Factories
  class AuditFactory
    def self.fetch(type)
      case type.to_sym
      when :integrity_logger
        Loggers::IntegrityLoggerAdapter.new
      else
        raise ArgumentError, "Unknown audit type: #{type}"
      end
    end
  end
end
