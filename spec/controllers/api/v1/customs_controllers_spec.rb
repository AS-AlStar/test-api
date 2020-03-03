# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::CustomsController do
  describe 'users_ip_list action' do
    subject(:list) { get :users_ip_list, format: :json }

    let(:test_ip) {  '192.168.1.1' }

    before { FactoryBot.create_list(:post, 5, :factory_user, user_ip: test_ip) }

    context 'when send correctly request' do
      it 'returns a success response' do
        expect(list.status).to eq 200
      end

      it 'returns the correct response with user_ip and logins' do
        expect(JSON.parse(list.body)['data'].first['attributes'])
          .to eq('user_ip' => test_ip, 'logins' => User.pluck(:login))
      end
    end
  end
end
