# frozen_string_literal: true

RSpec.shared_examples 'push job to queue' do |queue_name|
  subject(:job) { described_class.perform_async }

  it 'adds job to queue' do
    expect { job }.to change { Sidekiq::Queue.new(queue_name).size }.by(1)
  end
end
