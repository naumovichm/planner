# frozen_string_literal: true

class Meeting < Event
  validates :start_time, :end_time, presence: true
  validate :start_time_and_end_time_validy
  validate :event_date_time_matches_start_time

  private

  def start_time_and_end_time_validy
    return if start_time.blank? || end_time.blank?

    return unless end_time <= start_time

    errors.add(:end_time, :in_the_past)
  end

  def event_date_time_matches_start_time
    return if event_date.blank? || start_time.blank?

    return unless event_date.strftime('%H:%M') != start_time.strftime('%H:%M')

    errors.add(:start_time, :not_matched)
  end
end
