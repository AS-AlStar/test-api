# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TopPostsValidator, type: :model do
  subject(:validator) { described_class.new(attributes) }

  let(:attributes) { { limit: 10 } }

  context 'when send correctly data' do
    it 'is valid' do
      expect(validator.valid?).to eq(true)
    end
  end

  context 'when send wrong data' do
    context 'when send wrong data' do
      before { attributes[:limit] = nil }

      it 'is unvalid' do
        expect(validator.valid?).to eq(false)
      end
    end

    context 'when send params without limit' do
      before { attributes[:limit] = nil }

      it "is error 'Limit can't be blank'" do
        validator.valid?
        expect(validator.errors.full_messages.first).to eq("Limit can't be blank")
      end
    end
  end
end
