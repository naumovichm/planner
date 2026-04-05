# frozen_string_literal: true

module CategoriesServices
  class DeleteCategoryService
    def initialize(category:, user:)
      @category = category
      @user = user
    end

    def call
      category.belongs_to_many_users? ? delete_user_association : category.delete
    end

    private

    attr_reader :category, :user

    def delete_user_association
      user.categories.delete(category)
    end
  end
end
