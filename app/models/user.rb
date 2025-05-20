class User < ApplicationRecord
  AUDIT_TYPE = :integrity_logger
  include BanStatusable

  validates :idfa, presence: true, uniqueness: true
  validates :ban_status, presence: true
end
