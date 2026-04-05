# frozen_string_literal: true

module CategoriesServices
  class UpdateCategoryService
    def initialize(category:, category_params:, user:)
      @category = category
      @category_params = category_params
      @user = user
    end

    def call
      user.include_category?(category_params:) ? category.update(category_params) : update_category
    end

    private

    attr_reader :category, :category_params, :user

    def update_category_id
      user_category = UserCategory.where(user_id: user.id, category_id: category.id)
      user_category.update(category_id: Category.create_category(category_params:).id)
    end

    def update_category
      category.belongs_to_many_users? ? update_category_id : category.update(category_params)
    end
  end
end
