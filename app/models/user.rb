class User < ApplicationRecord
  enumeration :ban_status, class_name: BanStatusEnumeration

  validates :idfa, presence: true, uniqueness: true
  validates :ban_status_id, presence: true
end
