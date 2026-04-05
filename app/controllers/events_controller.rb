# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: %i[show edit update destroy]

  def index
    @events = EventsServices::SearchEventsService.new(
      search_params:,
      user: current_user
    ).call.page(params[:page]).per(params[:per_page])
  end

  def show; end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      redirect_to events_path, notice: t('flash.notice.event.create')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @event.update(event_params)
      redirect_to events_path, notice: t('flash.notice.event.update')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @event.delete
      redirect_to events_path, notice: t('flash.notice.event.delete')
    else
      redirect_to events_path, status: :unprocessable_entity
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :event_date, :reminder_on, :category_id)
  end

  def time_params
    params.permit(:time)
  end

  def search_params
    params.permit(:search, :category_id)
  end

  def set_event
    @event = current_user.events.find(params[:id])
  end
end
