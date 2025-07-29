# spec/requests/authentication_spec.rb
require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  let(:login_url)    { '/auth/login' }
  let(:logout_url)   { '/auth/logout' }
  let(:base_headers) { { 'Content-Type' => 'application/json' } }

  #Faker
  let(:password) { Faker::Internet.password(min_length: 10) }
  let!(:user) do
    create(:user,
           email:    Faker::Internet.unique.email,
           password: password,
           password_confirmation: password
    )
  end

  describe 'POST /auth/login' do
    let(:valid_credentials)   { { email: user.email, password: password }.to_json }
    let(:invalid_credentials) { { email: Faker::Internet.unique.email, password: Faker::Internet.password }.to_json }

    context 'When request is valid' do
      before { post login_url, params: valid_credentials, headers: base_headers }

      it 'returns an authentication token' do
        expect(json['auth_token']).not_to be_nil
      end
    end

    context 'When request is invalid' do
      before { post login_url, params: invalid_credentials, headers: base_headers }

      it 'returns a failure message' do
        expect(json['message']).to match(/Invalid credentials/i)
      end
    end
  end

  describe 'DELETE /auth/logout' do
    context 'when authenticated' do
      before do
        token = token_generator(user.id)
        delete logout_url, headers: json_headers(token: token)
      end

      it 'returns 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns logout message' do
        expect(json['message']).to eq('Logged out')
      end
    end

    context 'when token missing' do
      before { delete logout_url, headers: base_headers }

      it 'returns 422 atau 401' do
        expect([401, 422]).to include(response.status)
      end

      it 'returns error message' do
        expect(json['message']).to match(/Missing token|Unauthorized|Invalid token/i)
      end
    end
  end
end
