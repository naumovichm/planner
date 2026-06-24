# frozen_string_literal: true

class RemoveIsNotifiedAndAddReminderStatusToEvents < ActiveRecord::Migration[8.1]
  def change
    create_enum :reminder_status_type, %w[no_reminder pending notified]
    add_column :events, :reminder_status, :enum, enum_type: :reminder_status_type, default: 'no_reminder', null: false

    Event.where(is_notified: true).update_all(reminder_status: 'notified')

    remove_column :events, :is_notified, :boolean
  end
end
