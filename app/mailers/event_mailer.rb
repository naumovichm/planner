# frozen_string_literal: true

class EventMailer < ApplicationMailer
  default from: 'noreply@example.com'

  def reminder(user:, event:)
    @user = user
    @event = event
    @url = event_url(@event)
    mail(to: @user.email, subject: 'Reminder about upcoming event')
  end

  private

  def event_url(event)
    case event
    when Meeting
      events_meeting_url(event, locale: I18n.locale)
    when Notification
      events_notification_url(event, locale: I18n.locale)
    else
      raise "Unknown event type: #{event.class}"
    end
  end
end
