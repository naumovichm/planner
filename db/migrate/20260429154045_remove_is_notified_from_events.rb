# frozen_string_literal: true

class RemoveIsNotifiedFromEvents < ActiveRecord::Migration[8.1]
  def change
    remove_column :events, :is_notified, :boolean
  end
end
