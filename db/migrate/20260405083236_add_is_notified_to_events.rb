# frozen_string_literal: true

class AddIsNotifiedToEvents < ActiveRecord::Migration[8.1]
  def change
    add_column :events, :is_notified, :boolean, default: false
  end
end
