# frozen_string_literal: true

class AddTypeAndNotificationTextAndStartTimeAndEndTimeToEvents < ActiveRecord::Migration[8.1]
  def change
    change_table :events, bulk: true do |t|
      t.string :type
      t.time :start_time
      t.time :end_time
      t.text :notification_text
    end

    Event.where(type: nil).find_each do |event|
      event.update(type: 'Notification', notification_text: 'Backfill for validation')
    end
  end
end
