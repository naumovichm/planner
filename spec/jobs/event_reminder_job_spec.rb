# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventReminderJob, type: :job do
  let(:user) { create(:user) }
  let(:category) { create(:category) }
  let(:user_category) { create(:user_category, user: user, category: category) }
  let!(:event) do
    build(:event, user: user, category: category, reminder_on: 5.seconds.ago).tap do |e|
      e.save(validate: false)
    end
  end

  describe 'sidekiq queue' do
    subject(:job) { described_class.perform_async }

    it 'adds job to queue' do
      expect { job }.to change { Sidekiq::Queue.new('default').size }.by(1)
    end
  end

  describe 'make update in event' do
    before do
      described_class.new.perform
      event.reload
    end

    it 'updates is_notified to true' do
      expect(event.is_notified).to be true
    end

    it 'clears reminder_on' do
      expect(event.reminder_on).to be_nil
    end

    it 'sends reminder email' do
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end
  end
end
