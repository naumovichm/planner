# frozen_string_literal: true

class ChangeTypeToNotNullInEvents < ActiveRecord::Migration[8.1]
  def change
    change_column_null :events, :type, false
  end
end
