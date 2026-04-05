# frozen_string_literal: true

module EventsHelper
  def event_numb(index)
    page = params[:page].to_i.positive? ? params[:page].to_i : 1
    per_page = params[:per_page].to_i.positive? ? params[:per_page].to_i : 20
    calc_event_num(page, per_page, index)
  end

  def calc_event_num(page, per_page, index)
    (page - 1) * per_page + index + 1
  end
end
