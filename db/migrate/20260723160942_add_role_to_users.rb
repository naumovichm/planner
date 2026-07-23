# frozen_string_literal: true

class AddRoleToUsers < ActiveRecord::Migration[8.1]
  def change
    change_table :users do |t|
      t.belongs_to :role, foreign_key: true, null: false, default: 1
    end
  end
end
