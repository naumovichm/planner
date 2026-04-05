# frozen_string_literal: true

module Events
  class SearchQuery
    def initialize(search_params:, user:)
      @search_params = search_params
      @user_events = user.events
    end

    def call
      fetch_event
    end

    private

    def fetch_event
      search_field = @search_params[:search].presence || ''
      category_id = @search_params[:category].presence&.to_i
      category_id ? @user_events.by_category(category_id).by_name(search_field) : @user_events.by_name(search_field)
    end
  end
end
