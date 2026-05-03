# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventReminderJob, type: :job do
  let(:user) { create(:user) }
  let(:category) { create(:category) }
  let(:user_category) { create(:user_category, user: user, category: category) }
  let!(:meeting) do
    build(:meeting, user: user, category: category, reminder_on: 5.seconds.ago).tap do |e|
      e.save(validate: false)
    end
  end

  describe 'sidekiq queue' do
    it_behaves_like 'push job to queue', 'default'
  end

  describe 'make update in event' do
    subject(:job_perform) do
      described_class.new.perform
      meeting.reload
    end

    it 'updates reminder status is notified' do
      expect { job_perform }.to(change(meeting, :reminder_status).from('pending').to('notified'))
    end

    it 'sends reminder email' do
      expect { job_perform }.to(change(ActionMailer::Base.deliveries, :count).from(0).to(1))
    end
  end
end
