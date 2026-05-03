# frozen_string_literal: true

class AddStartTimeEndTimeToEvents < ActiveRecord::Migration[8.1]
  def change
    change_table :events, bulk: true do |t|
      t.time :start_time
      t.time :end_time
    end
  end
end
