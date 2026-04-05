# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  scope '(:locale)', locale: /#{I18n.available_locales.join('|')}/ do
    root 'home#index'
    devise_for :users, path: '', controllers: { registrations: 'users/registrations' }
    resources :categories
    resources :events
  end
end
