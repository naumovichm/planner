# frozen_string_literal: true

class Notification < Event
  validates :notification_text, presence: true
end
