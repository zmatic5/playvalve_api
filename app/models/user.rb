class User < ApplicationRecord
  AUDIT_TYPE = :integrity_logger
  include BanStatusable

  validates :idfa, presence: true, uniqueness: true
  validates :ban_status, presence: true

  after_create :create_audit
  after_update :create_audit, if: :saved_change_to_ban_status?

  def create_audit
    ::Factories::AuditFactory.fetch(AUDIT_TYPE).log(self)
  end
end
