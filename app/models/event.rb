# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :category, dependent: :destroy
  belongs_to :user, dependent: :destroy

  validates :name, presence: true
  validates :event_date, presence: true
  validate :reminder_date_validity, if: :reminder_on_changed?
  validate :event_date_validity

  default_scope { order(event_date: :asc) }

  scope :future, -> { where(event_date: DateTime.now.end_of_day..) }
  scope :today, -> { where(event_date: DateTime.now.beginning_of_day..DateTime.now.end_of_day) }
  scope :by_category, ->(category_id) { where(category_id:) }
  scope :by_name, ->(name) { where('name like ?', "%#{name}%") }
  scope :for_notifications, -> { where(is_notified: false, reminder_on: ..Time.zone.now) }

  paginates_per 20

  private

  def reminder_date_validity
    return if reminder_on.blank?

    if reminder_on.past?
      errors.add(:reminder_on, :past)
    elsif reminder_on >= event_date
      errors.add(:reminder_on, :too_late)
    end
  end

  def event_date_validity
    return if event_date&.future?

    errors.add(:event_date, :past)
  end
end
