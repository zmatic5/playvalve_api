# frozen_string_literal: true

class AddDefaultsToIntegrityLogBooleans < ActiveRecord::Migration[7.1]
  def change
    change_column_default :integrity_logs, :rooted_device, false
    change_column_null :integrity_logs, :rooted_device, false

    change_column_default :integrity_logs, :vpn, false
    change_column_null :integrity_logs, :vpn, false

    change_column_default :integrity_logs, :proxy, false
    change_column_null :integrity_logs, :proxy, false
  end
end
