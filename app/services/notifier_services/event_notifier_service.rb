# frozen_string_literal: true

module NotifierServices
  class EventNotifierService
    def initialize(event:)
      @event = event
    end

    def call
      EventMailer.reminder(user: @event.user, event: @event).deliver_now
    end
  end
end
