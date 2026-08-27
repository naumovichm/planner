# frozen_string_literal: true

class AddRoleToUsers < ActiveRecord::Migration[8.1]
  def change
    change_table :users do |t|
      t.belongs_to :role, foreign_key: true
      User.where(role_id: nil).update_all(role_id: Role.find_by(name: 'common').id)
      change_column_null :users, :role_id, false
    end
  end
end
