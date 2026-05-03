# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
  subject(:event) { build(:event) }

  context 'when event is valid' do
    it { expect(event).to be_valid }
  end

  describe 'validations' do
    describe 'presence of name and event_date' do
      it { expect(event).to validate_presence_of :name }
      it { expect(event).to validate_presence_of :event_date }
    end

    describe 'event_date is valid' do
      let(:event_with_valid_event_date) { build(:event, event_date: Date.tomorrow) }

      it { expect(event_with_valid_event_date).to be_valid }
    end

    describe 'event_date is in the past' do
      let(:event_with_past_event_date) { build(:event, event_date: Date.yesterday) }

      it { expect(event_with_past_event_date).not_to be_valid }
    end

    describe 'reminder_on is valid' do
      let(:event_with_valid_reminder_on) { build(:event, event_date: Date.tomorrow + 1, reminder_on: Date.tomorrow) }

      it { expect(event_with_valid_reminder_on).to be_valid }
    end

    describe 'reminder_on greater than event_date' do
      let(:event_with_future_reminder_on) do
        build(:event, event_date: Date.tomorrow + 1, reminder_on: Date.tomorrow + 2)
      end

      it { expect(event_with_future_reminder_on).not_to be_valid }
    end

    describe 'reminder_on match even_date' do
      let(:event_with_the_same_date) { build(:event, event_date: Date.tomorrow, reminder_on: Date.tomorrow) }

      it { expect(event_with_the_same_date).not_to be_valid }
    end

    describe 'reminder_on in the past' do
      let(:event_with_past_reminder_on) { build(:event, event_date: Date.tomorrow + 1, reminder_on: Date.yesterday) }

      it { expect(event_with_past_reminder_on).not_to be_valid }
    end
  end

  describe 'associations' do
    it { expect(event).to belong_to(:user).dependent(:destroy) }
    it { expect(event).to belong_to(:category).dependent(:destroy) }
  end

  describe 'scopes' do
    let!(:category) { create(:category) }
    let!(:today_event) { build(:event, category:, event_date: DateTime.now).tap { |e| e.save(validate: false) } }
    let!(:future_event) { create(:event, category:, event_date: DateTime.tomorrow) }

    describe '.future' do
      it { expect(described_class.future).to contain_exactly(future_event) }
    end

    describe '.today' do
      it { expect(described_class.today).to contain_exactly(today_event) }
    end
  end

  describe 'aasm' do
    let(:event_with_reminder) { create(:event, :with_reminder) }

    describe 'initial state when no reminder' do
      it { expect(event.reminder_status).to eq 'no_reminder' }
    end

    describe 'when reminder is present' do
      it { expect(event_with_reminder.reminder_status).to eq 'pending' }
    end

    describe 'when reminder_status changes from no_reminder to pending' do
      before { event.reminder_on = event.event_date - 1.hour }

      it { expect { event.save }.to change(event, :reminder_status).from('no_reminder').to('pending') }
    end

    describe 'when reminder_status changes from pending to notified' do
      it {
        expect do
          event_with_reminder.notify!
        end.to change(event_with_reminder, :reminder_status).from('pending').to('notified')
      }
    end
  end
end
