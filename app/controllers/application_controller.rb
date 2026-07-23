# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_locale
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale == I18n.default_locale ? nil : I18n.locale }
  end

  def render_not_found
    render file: Rails.root.join('public/404.html'), status: :not_found, layout: false
  end
end
