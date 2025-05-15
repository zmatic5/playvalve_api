class ChangeBanStatusIdToBanStatusInUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :ban_status, :string, default: 'not_banned'
    remove_column :users, :ban_status_id, :integer
  end
end
