# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostValidator, type: :model do
  subject(:post_validator) { described_class.new(post_validator_attributes) }

  let(:post_validator_attributes) { FactoryBot.attributes_for(:post, login: 'test_user') }

  context 'when send correctly data' do
    it 'is valid' do
      expect(post_validator.valid?).to eq(true)
    end
  end

  context 'when send wrong data' do
    context 'when send wrong data' do
      before { post_validator_attributes[:login] = nil }

      it 'is unvalid' do
        expect(post_validator.valid?).to eq(false)
      end
    end

    context 'when send params without login' do
      before { post_validator_attributes[:login] = nil }

      it "is error 'Login can't be blank'" do
        post_validator.valid?
        expect(post_validator.errors.full_messages.first).to eq("Login can't be blank")
      end
    end

    context 'when send params without title' do
      before { post_validator_attributes[:title] = nil }

      it "is error 'Title can't be blank'" do
        post_validator.valid?
        expect(post_validator.errors.full_messages.first).to eq("Title can't be blank")
      end
    end

    context 'when send params without description' do
      before { post_validator_attributes[:description] = nil }

      it "is error 'Description can't be blank'" do
        post_validator.valid?
        expect(post_validator.errors.full_messages.first).to eq("Description can't be blank")
      end
    end

    context 'when send params without user ip' do
      before { post_validator_attributes[:user_ip] = nil }

      it "is error 'User ip can't be blank'" do
        post_validator.valid?
        expect(post_validator.errors.full_messages.first).to eq("User ip can't be blank")
      end
    end
  end
end
