# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :authenticate_user!
  def index
    @events = EventsServices::SearchEventsService.new(
      search_params:,
      user_events: policy_scope(Event)
    ).call.page(params[:page]).per(params[:per_page])
  end

  def search_params
    params.permit(:search, :category_id)
  end
end
