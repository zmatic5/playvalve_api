class UserCheckFlow
  def initialize(idfa:, rooted_device:, ip:, country:)
    @idfa = idfa
    @rooted_device = rooted_device
    @ip = ip
    @country = country
  end

  def call
    user = User.find_or_initialize_by(idfa: idfa)

    return user if user.persisted? && user.banned?

    evaluator = BanEvaluatorService.new(
      rooted_device: rooted_device,
      ip: ip,
      country: country
    )

    user = UserUpserterService.new(
      user: user,
      ban_status: evaluator.banned? ? :banned : :allowed
    ).call

    if user.saved_change_to_id? || user.saved_change_to_ban_status?
      begin
        ::Factories::AuditFactory.fetch(User::AUDIT_TYPE).log(
          user: user,
          ip: ip,
          country: country,
          rooted_device: rooted_device
        )
      rescue => e
        Rails.logger.error("Audit log failed: #{e.message}")
      end
    end

    user
  end

  private

  attr_reader :idfa, :rooted_device, :ip, :country
end
