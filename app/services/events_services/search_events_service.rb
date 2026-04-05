# frozen_string_literal: true

module EventsServices
  class SearchEventsService
    def initialize(search_params:, user:)
      @search_params = search_params
      @user = user
    end

    def call
      if @search_params.present?
        Events::SearchQuery.new(search_params: @search_params, user: @user).call
      else
        @user.events
      end
    end
  end
end
