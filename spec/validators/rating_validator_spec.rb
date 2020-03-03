# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RatingValidator, type: :model do
  subject(:rating_validator) { described_class.new(rating_validator_attributes) }

  let(:test_post) { FactoryBot.create(:post, :factory_user) }
  let(:rating_validator_attributes) { FactoryBot.attributes_for(:rating, post_id: test_post.id) }

  context 'when send correctly data' do
    it 'is valid' do
      expect(rating_validator.valid?).to eq(true)
    end
  end

  context 'when send wrong data' do
    context 'when send wrong data' do
      before { rating_validator_attributes[:star] = nil }

      it 'is unvalid' do
        expect(rating_validator.valid?).to eq(false)
      end
    end

    context 'when send params without star' do
      before { rating_validator_attributes[:star] = nil }

      it "is error 'Star is not a number'" do
        rating_validator.valid?
        expect(rating_validator.errors.full_messages.first).to eq('Star is not a number')
      end
    end

    context 'when send star greater than 5' do
      before { rating_validator_attributes[:star] = 6 }

      it "is error 'Star must be less than or equal to 5'" do
        rating_validator.valid?
        expect(rating_validator.errors.full_messages.first).to eq('Star must be less than or equal to 5')
      end
    end

    context 'when send star less than 1' do
      before { rating_validator_attributes[:star] = 0 }

      it "is error 'Star must be greater than or equal to 1'" do
        rating_validator.valid?
        expect(rating_validator.errors.full_messages.first).to eq('Star must be greater than or equal to 1')
      end
    end

    context 'when send params without post_id' do
      before { rating_validator_attributes[:post_id] = nil }

      it "is error 'Post id can't be blank'" do
        rating_validator.valid?
        expect(rating_validator.errors.full_messages.first).to eq("Post can't be blank")
      end
    end
  end
end
