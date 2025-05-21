# frozen_string_literal: true

class ChangeBanStatusIdToBanStatusInIntegrityLog < ActiveRecord::Migration[7.1]
  def change
    add_column :integrity_logs, :ban_status, :string, default: 'not_banned'
    remove_column :integrity_logs, :ban_status_id, :integer
  end
end
