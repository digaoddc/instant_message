# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Dialects::Yoda, :vcr do
  describe '.translate' do
    subject(:perform) { described_class.new(text).translate }
    let(:text) { 'Master Obiwan has lost a planet' }

    context 'request success' do
      it { is_expected.to eq 'Lost a planet,  master obiwan has' }
    end

    context 'request failed' do
      it { is_expected.to eq text }
    end
  end
end
