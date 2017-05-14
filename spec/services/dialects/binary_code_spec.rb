# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Dialects::BinaryCode do
  describe '.translate' do
    subject(:perform) { described_class.new(text).translate }
    let(:text) { 'Master Obiwan has lost a planet' }

    it { is_expected.to eq ['0100110101100001011100110111010001100101'] }
  end
end
