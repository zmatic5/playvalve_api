class User < ApplicationRecord
  include BanStatusable

  validates :idfa, presence: true, uniqueness: true
  validates :ban_status, presence: true

  after_create :log
  after_update :log, if: :saved_change_to_ban_status?

  def log
    IntegrityLogger.log(
      user: self,
      ip: Current.ip,
      country: Current.country,
      rooted_device: Current.rooted_device,
      vpn_data: Current.vpn_data
    )
  end
end
