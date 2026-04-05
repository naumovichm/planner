# frozen_string_literal: true

class CreateUserCategories < ActiveRecord::Migration[8.1]
  def change
    create_table :user_categories do |t|
      t.belongs_to :user, null: false, foreign_key: { on_delete: :cascade }
      t.belongs_to :category, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
    add_index :user_categories, %i[user_id category_id], unique: true
  end
end
