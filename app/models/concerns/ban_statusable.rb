# frozen_string_literal: true

module BanStatusable
  extend ActiveSupport::Concern

  included do
    enum :ban_status, {
      allowed: 'allowed',
      banned: 'banned'
    }
  end
end
