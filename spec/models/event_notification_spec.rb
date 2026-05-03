# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Notification, type: :model do
  subject(:notification) { build(:notification) }

  describe 'when notification is valid' do
    it { expect(notification).to be_valid }
  end

  describe 'validations' do
    describe 'presence of notification_text' do
      it { expect(notification).to validate_presence_of :notification_text }
    end
  end
end
