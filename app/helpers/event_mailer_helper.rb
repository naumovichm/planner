# frozen_string_literal: true

module EventMailerHelper
  def reminder_details(event)
    case event
    when Meeting
      t('mailer.meeting_time', start: event.start_time.strftime('%H:%M'), end: event.end_time.strftime('%H:%M'))
    when Notification
      t('mailer.notification_text', text: event.notification_text)
    else
      raise "Unknown event type: #{event.class}"
    end
  end
end
