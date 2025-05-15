class User < ApplicationRecord
  include BanStatusable

  validates :idfa, presence: true, uniqueness: true
  validates :ban_status, presence: true
end
