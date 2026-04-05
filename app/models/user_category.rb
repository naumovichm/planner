# frozen_string_literal: true

class UserCategory < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :category, dependent: :destroy
end
