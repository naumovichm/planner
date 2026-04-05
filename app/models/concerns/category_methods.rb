# frozen_string_literal: true

module CategoryMethods
  extend ActiveSupport::Concern

  included do
    def self.create_category(category_params:)
      find_or_create_by(category_params)
    end
  end

  def belongs_to_many_users?
    users.count > 1
  end
end
