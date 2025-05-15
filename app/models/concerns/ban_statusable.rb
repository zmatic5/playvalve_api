module BanStatusable
  extend ActiveSupport::Concern

  included do
    enum ban_status: {
      not_banned: 'not_banned',
      banned: 'banned'
    }
  end
end
