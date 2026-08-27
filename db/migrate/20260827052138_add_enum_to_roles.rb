# frozen_string_literal: true

class AddEnumToRoles < ActiveRecord::Migration[8.1]
  def up
    create_enum :role_name, %w[common admin]
    change_column :roles, :name, :enum, enum_type: :role_name, using: 'name::role_name'
  end

  def down
    change_column :roles, :name, :string
    drop_enum :role_name
  end
end
