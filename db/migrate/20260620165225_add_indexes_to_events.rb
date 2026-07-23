# frozen_string_literal: true

class AddIndexesToEvents < ActiveRecord::Migration[8.1]
  def change
    change_table :events, bulk: true do |t|
      t.index %i[user_id type]
      t.index %i[reminder_status reminder_on]
      t.index :event_date
    end
  end
end
