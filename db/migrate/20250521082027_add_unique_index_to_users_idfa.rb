# frozen_string_literal: true

class AddUniqueIndexToUsersIdfa < ActiveRecord::Migration[7.1]
  def change
    add_index :users, :idfa, unique: true
  end
end
