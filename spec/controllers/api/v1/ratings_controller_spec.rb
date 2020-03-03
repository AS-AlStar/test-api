# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::RatingsController do
  let(:test_post) { FactoryBot.create(:post, :factory_user) }
  let(:rating_attributes) { FactoryBot.attributes_for(:rating, post_id: test_post.id) }

  describe 'create rating' do
    subject(:test_rating) { post :create, params: rating_attributes, format: :json }

    context 'when send valid ratings data' do
      it 'returns a success test_rating' do
        expect(test_rating.status).to eq 200
      end

      it 'Rating.count changed by 1' do
        expect { test_rating }.to change(Rating, :count).by(1)
      end

      it 'returns the correct average rating' do
        expect(JSON.parse(test_rating.body).dig('data', 'attributes')).to eq('average' => rating_attributes[:star])
      end
    end

    context 'when send invalid ratings data' do
      before { rating_attributes[:star] = nil }

      it 'returns a test_rating with status 422' do
        expect(test_rating.status).to eq 422
      end
    end

    context 'when send invalid ratings data: star is nil' do
      before { rating_attributes[:star] = nil }

      it "returns error 'Star is not a number'" do
        expect(JSON.parse(test_rating.body)).to eq('errors' => ['Star is not a number'])
      end
    end

    context 'when send invalid ratings: star more 5' do
      before { rating_attributes[:star] = 10 }

      it "returns error 'Star must be less than or equal to 5'" do
        expect(JSON.parse(test_rating.body)).to eq('errors' => ['Star must be less than or equal to 5'])
      end
    end

    context 'when send invalid ratings: star less 1' do
      before { rating_attributes[:star] = 0 }

      it "returns error 'Star must be greater than or equal to 1'" do
        expect(JSON.parse(test_rating.body)).to eq('errors' => ['Star must be greater than or equal to 1'])
      end
    end

    context 'when send invalid ratings data: ' do
      before { rating_attributes[:post_id] = nil }

      it "returns error 'Post_id is not a number'" do
        expect(JSON.parse(test_rating.body)).to eq('errors' => ["Post can't be blank"])
      end
    end

    context 'when send invalid ratings: post not found' do
      before { rating_attributes[:post_id] = 10 }

      it "returns error 'Star must be less than or equal to 5'" do
        expect(JSON.parse(test_rating.body)).to eq('errors' => 'Post not found by id: 10')
      end
    end
  end
end
