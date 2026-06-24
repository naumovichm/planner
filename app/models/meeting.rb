# frozen_string_literal: true

class Meeting < Event
  validates :start_time, :end_time, presence: true
  validates :end_time, comparison: { greater_than: :start_time }, if: -> { start_time.present? }
  validate :event_date_time_matches_start_time

  def display_reminder
    I18n.t('mailer.meeting_time', start: start_time.strftime('%H:%M'), end: end_time.strftime('%H:%M'))
  end

  private

  def event_date_time_matches_start_time
    return if event_date.blank? || start_time.blank?

    return unless event_date.strftime('%H:%M') != start_time.strftime('%H:%M')

    errors.add(:start_time, :not_matched)
  end
end
