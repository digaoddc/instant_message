# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OnlineStorage do
  let(:storage) { described_class.new }
  let(:record) { 'digao' }
  let(:record2) { 'ze' }

  before(:each) do
    redis = Redis.new
    redis.flushdb
  end

  context '#save_user' do
    subject { storage.save_user record }
    it { is_expected.to eq true }
  end

  context '#users' do
    subject { storage.users }
    before { storage.save_user record }
    it { is_expected.to eq [record] }
  end

  context '#pop' do
    subject { storage.pop record }
    before do
      storage.save_user record
      storage.save_user record2
    end

    it 'remove one item' do
      subject
      users = storage.users
      expect(users).to eq([record2])
    end
  end

  context '#clear' do
    subject { storage.clear }
    before do
      storage.save_user record
      storage.save_user record2
    end

    it 'removes all items' do
      subject
      users = storage.users
      expect(users).to eq([])
    end
  end
end
