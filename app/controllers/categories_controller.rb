# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: %i[show edit update destroy]
  def index
    @categories = current_user.categories.page(params[:page]).per(params[:per_page])
  end

  def show; end

  def edit; end

  def update
    if CategoriesServices::UpdateCategoryService.new(category: @category, category_params:,
                                                     user: current_user).call
      redirect_to categories_path, notice: t('flash.notice.category.update')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if CategoriesServices::CreateCategoryService.new(category: @category, category_params:,
                                                     user: current_user).call
      redirect_to categories_path, notice: t('flash.notice.category.create')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    if CategoriesServices::DeleteCategoryService.new(category: @category, user: current_user).call
      redirect_to categories_path, notice: t('flash.notice.category.delete')
    else
      redirect_to categories_path, status: :unprocessable_entity
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = current_user.categories.find(params[:id])
  end
end
