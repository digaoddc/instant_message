# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MessagesBroadcaster do
  let(:data) do
    {
      message: 'hello',
      from: 'me',
      dialect: 'teste'
    }.with_indifferent_access
  end

  describe '#execute' do
    subject { described_class.new(data).execute }
    let(:messages) do
      data.merge(time: Time.now.strftime('%D %R')).symbolize_keys
    end

    it 'broadcasts a message' do
      expect(ActionCable.server).to receive(:broadcast).with('messages_channel', messages)
      subject
    end
  end
end
