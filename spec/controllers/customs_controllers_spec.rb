# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::CustomsController do
  render_views

  describe 'users_ip_list action' do
    response { get :users_ip_list, format: :json }

    before { FactoryBot.create_list(:post, 5, :factory_user, user_ip: '192.168.1.1') }

    context 'when send correctly request' do
      it 'returns a success response' do
        expect(response.status).to eq 200
      end

      it 'returns the correct response with user_ip and logins' do
        expect(JSON.parse(response.body)['data'].first['attributes'])
          .to eq('user_ip' => '192.168.1.1', 'logins' => User.all.map(&:login))
      end
    end
  end
end
