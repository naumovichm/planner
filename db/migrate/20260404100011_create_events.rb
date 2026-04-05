# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[8.1]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.text :description
      t.datetime :event_date, null: false
      t.datetime :reminder_on

      t.belongs_to :category, null: false, foreign_key: { on_delete: :cascade }
      t.belongs_to :user, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
