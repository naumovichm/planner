# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Planner
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.1

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Permitted locales available for the application
    config.i18n.load_path += Dir[Rails.root.join('config/locales/*.{rb,yml}')]

    # Permitted locales available for the application
    config.i18n.available_locales = %i[en ru]

    # Set default locale
    config.i18n.default_locale = :en

    # Set timezone of Belarus
    config.time_zone = 'Minsk'
  end
end
