# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DialectTranslator do
  describe '.perform' do
    subject(:perform) { described_class.perform(text, dialect) }
    let(:text) { 'Hello' }

    context 'when dialect is binary code' do
      let(:dialect) { 'binary_code' }
      let(:dialect_mock) { double }

      before do
        allow(Dialects::BinaryCode).to receive(:new).with(text) { dialect_mock }
      end

      it 'calls translate' do
        expect(dialect_mock).to receive(:translate)
        perform
      end
    end

    context 'when dialect is yoda' do
      let(:dialect) { 'yoda' }
      let(:dialect_mock) { double }

      before do
        allow(Dialects::Yoda).to receive(:new).with(text) { dialect_mock }
      end

      it 'calls translate' do
        expect(dialect_mock).to receive(:translate)
        perform
      end
    end

    context 'when dialect is vallery girl' do
      let(:dialect) { 'vallery_girl' }
      let(:dialect_mock) { double }

      before do
        allow(Dialects::ValleryGirl).to receive(:new).with(text) { dialect_mock }
      end

      it 'calls translate' do
        expect(dialect_mock).to receive(:translate)
        perform
      end
    end

    context 'when dialect is unknown' do
      let(:dialect) { 'unknown' }

      it 'return raw text' do
        is_expected.to eq(text)
      end
    end
  end
end
