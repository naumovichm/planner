# frozen_string_literal: true

class EventReminderJob
  include Sidekiq::Job

  def perform
    Event.for_notifications.find_each do |event|
      send_reminder(event)
    end
  end

  private

  def send_reminder(event)
    EventMailer.reminder(user: event.user, event: event).deliver_now
    event.update(is_notified: true, reminder_on: nil)
  end
end
