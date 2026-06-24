# frozen_string_literal: true

module Events
  class NotificationsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_event, only: %i[show edit update destroy]

    def show; end

    def new
      @notification = Notification.new
    end

    def create
      @notification = Notification.new(event_params)
      @notification.user = current_user
      if @notification.save
        redirect_to events_path, notice: t('flash.notice.event.create')
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit; end

    def update
      if @notification.update(event_params)
        redirect_to events_path, notice: t('flash.notice.event.update')
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      if @notification.delete
        redirect_to events_path, notice: t('flash.notice.event.delete')
      else
        redirect_to events_path, status: :unprocessable_entity
      end
    end

    private

    def event_params
      params.require(:notification).permit(:name, :description, :event_date, :reminder_on, :category_id,
                                           :notification_text)
    end

    def set_event
      @notification = current_user.notifications.find(params[:id])
    end
  end
end
