# frozen_string_literal: true

class Notification < Event
  validates :notification_text, presence: true

  def display_reminder
    I18n.t('mailer.notification_text', text: notification_text)
  end
end
