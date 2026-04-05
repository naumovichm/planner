# frozen_string_literal: true

module UserMethods
  extend ActiveSupport::Concern

  def include_category?(category_params:)
    categories.exists?(category_params)
  end
end
