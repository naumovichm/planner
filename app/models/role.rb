# frozen_string_literal: true

class Role < ApplicationRecord
  enum :name, { common: 'common', admin: 'admin' }
  validates :name, presence: true, uniqueness: true

  has_many :users, dependent: :nullify
end
