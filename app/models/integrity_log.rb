# frozen_string_literal: true

class IntegrityLog < ApplicationRecord
  include BanStatusable

  validates :ban_status, presence: true
end
