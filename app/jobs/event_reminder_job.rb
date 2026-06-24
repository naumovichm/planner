# frozen_string_literal: true

class EventReminderJob
  include Sidekiq::Job

  def perform
    Event.for_notifications.includes(:user).find_each do |event|
      event.notify!
    rescue StandardError => e
      Rails.logger.error "Notification with id #{event.id} failed with #{e.message}"
    end
  end
end
