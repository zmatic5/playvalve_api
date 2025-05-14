class IntegrityLog < ApplicationRecord
  enumeration :ban_status, class_name: BanStatusEnumeration

  validates :ban_status_id, presence: true
end
