# frozen_string_literal: true

class EventReminderJob
  include Sidekiq::Job

  def perform
    Event.for_notifications.includes(:user).find_each(&:notify!)
  end
end
