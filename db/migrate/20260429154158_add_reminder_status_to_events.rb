# frozen_string_literal: true

class AddReminderStatusToEvents < ActiveRecord::Migration[8.1]
  def change
    add_column :events, :reminder_status, :text
  end
end
