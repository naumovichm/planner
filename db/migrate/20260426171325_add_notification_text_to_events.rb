# frozen_string_literal: true

class AddNotificationTextToEvents < ActiveRecord::Migration[8.1]
  def change
    add_column :events, :notification_text, :text
  end
end
