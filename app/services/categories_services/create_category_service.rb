# frozen_string_literal: true

module CategoriesServices
  class CreateCategoryService
    def initialize(category:, category_params:, user:)
      @category_params = category_params
      @user = user
      @category = category
    end

    def call
      if category_params[:name].blank?
        category.save
      else
        add_category_to_user
      end
    end

    private

    attr_reader :category, :category_params, :user

    def add_category_to_user
      if user.include_category?(category_params:)
        category.save
      else
        UserCategory.create(category: Category.create_category(category_params:),
                            user:)
      end
    end
  end
end
