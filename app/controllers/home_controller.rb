# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @user = UserPresenter.new(current_user) if current_user
  end
end
