# frozen_string_literal: true

class UserPresenter
  def initialize(user)
    @user = user
  end

  def user_name
    @user.last_name.presence || "#{@user.first_name} #{@user.last_name}"
  end

  def future_events_count
    @user.events.future.count
  end

  def today_events_count
    @user.events.today.count
  end
end
