# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::PostsController do
  let(:post_attributes) { FactoryBot.attributes_for(:post, login: 'user_login') }

  render_views

  describe 'create post' do
    response { post :create, params: post_attributes, format: :json }

    context 'when send valid posts data' do
      it 'returns a success response' do
        expect(response.status).to eq 200
      end

      it 'Post.count changed by 1' do
        expect { response }.to change(Post, :count).by(1)
      end

      it 'returns the correct post data' do
        expect(JSON.parse(response.body).dig('data', 'attributes')).to eq(post_attributes.with_indifferent_access)
      end
    end

    context 'when send invalid posts data' do
      before { post_attributes[:title] = nil }

      it 'returns a response with status 422' do
        expect(response.status).to eq 422
      end
    end

    context 'when send invalid posts data: Title is nil' do
      before { post_attributes[:title] = nil }

      it "returns error 'Title can't be blank'" do
        expect(JSON.parse(response.body)).to eq('errors' => ["Title can't be blank"])
      end
    end

    context 'when send invalid posts data: Description is nil' do
      before { post_attributes[:description] = nil }

      it "returns error 'Description can't be blank'" do
        expect(JSON.parse(response.body)).to eq('errors' => ["Description can't be blank"])
      end
    end

    context 'when send invalid posts data: login is nil' do
      before { post_attributes[:login] = nil }

      it "returns error 'Login can't be blank'" do
        expect(JSON.parse(response.body)).to eq('errors' => ["Login can't be blank"])
      end
    end

    context 'when send invalid posts data: user ip is nil' do
      before { post_attributes[:user_ip] = nil }

      it "returns error 'User ip can't be blank'" do
        expect(JSON.parse(response.body)).to eq('errors' => ["User ip can't be blank"])
      end
    end
  end
end
