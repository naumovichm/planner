# frozen_string_literal: true

module Events
  class MeetingsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_event, only: %i[show edit update destroy]

    def show; end

    def new
      @meeting = Meeting.new
    end

    def create
      @meeting = Meeting.new(event_params)
      @meeting.user = current_user
      if @meeting.save
        redirect_to events_path, notice: t('flash.notice.event.create')
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit; end

    def update
      if @meeting.update(event_params)
        redirect_to events_path, notice: t('flash.notice.event.update')
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      if @meeting.delete
        redirect_to events_path, notice: t('flash.notice.event.delete')
      else
        redirect_to events_path, status: :unprocessable_entity
      end
    end

    private

    def event_params
      params.require(:meeting).permit(:name, :description, :event_date, :reminder_on, :category_id, :start_time,
                                      :end_time)
    end

    def set_event
      @meeting = current_user.events.find(params[:id])
    end
  end
end
