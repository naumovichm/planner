# frozen_string_literal: true

class AddTypeToEvents < ActiveRecord::Migration[8.1]
  def change
    add_column :events, :type, :string
  end
end
