# frozen_string_literal: true

class EventMailer < ApplicationMailer
  default from: 'noreply@example.com'

  def reminder(user:, event:)
    @user = user
    @event = event
    @url = event_url(event, locale: I18n.locale)
    mail(to: @user.email, subject: "Reminder: #{@event.name} is coming soon")
  end
end
