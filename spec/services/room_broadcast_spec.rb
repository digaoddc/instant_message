# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RoomsBroadcast do
  let(:cast) { described_class.new(data, connection) }
  let(:connection) { double('connection') }
  let(:data) do
    {
      event: 'online',
      from: 'me'
    }.with_indifferent_access
  end

  describe '#speak' do
    subject { cast.speak }
    let(:messages) { data.symbolize_keys }

    it 'broadcasts a message' do
      expect(ActionCable.server).to receive(:broadcast).with('room_channel', messages)
      subject
    end
  end

  describe '#unsubscribed' do
    subject { cast.unsubscribed }
    let(:connection) { double('connection', current_user: 'me') }
    let(:storage) { double('storage') }

    before do
      allow(cast).to receive(:connection) { connection }
      allow(OnlineStorage).to receive(:new) { storage }
      expect(storage).to receive(:pop).with('me')
    end
    let(:messages) do
      {
        event: 'offline',
        from: 'me'
      }.symbolize_keys
    end

    it 'broadcasts a message' do
      expect(ActionCable.server).to receive(:broadcast).with('room_channel', messages)
      subject
    end
  end

  describe '#persist_user' do
    subject { cast.persist_user }
    let(:connection) { double('connection', current_user: 'me') }

    before(:each) do
      redis = Redis.new
      redis.flushdb
    end

    it 'broadcasts a message' do
      subject
      users = OnlineStorage.new.users
      expect(users).to eq(['me'])
    end
  end
end
