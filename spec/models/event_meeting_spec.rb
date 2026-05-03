# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Meeting, type: :model do
  subject(:meeting) { build(:meeting) }

  context 'when meeting is valid' do
    it { expect(meeting).to be_valid }
  end

  describe 'validations' do
    describe 'presence of start_time and end_time' do
      it { expect(meeting).to validate_presence_of :start_time }
      it { expect(meeting).to validate_presence_of :end_time }
    end

    describe 'start_time does not match to time of event_date' do
      let(:meeting_with_invalid_start_time) { build(:meeting, :with_invalid_start_time) }

      it { expect(meeting_with_invalid_start_time).not_to be_valid }
    end

    describe 'end_time less than start_time' do
      let(:meeting_with_invalid_end_time) { build(:meeting, :with_invalid_end_time) }

      it { expect(meeting_with_invalid_end_time).not_to be_valid }
    end
  end
end
