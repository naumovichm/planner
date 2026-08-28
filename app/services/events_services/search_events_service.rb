# frozen_string_literal: true

module EventsServices
  class SearchEventsService
    def initialize(search_params:, user_events:)
      @search_params = search_params
      @user_events = user_events
    end

    def call
      if @search_params.present?
        Events::SearchQuery.new(search_params: @search_params, user_events: @user_events).call
      else
        @user_events
      end
    end
  end
end
