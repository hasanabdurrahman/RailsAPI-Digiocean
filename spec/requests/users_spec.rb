require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  let(:user) { build(:user) }
  let(:headers) { valid_headers.except('Authorization') }
  let(:valid_attributes) do
    attributes_for(:user, password_confirmation: user.password)
  end

  # User signup test suite
  describe 'POST /signup' do
    context 'when valid request' do
      before { post '/signup', params: valid_attributes.to_json, headers: headers }

      it 'creates a new user' do
        expect(response).to have_http_status(201)
      end

      it 'returns success message' do
        expect(json['message']).to match(/Account created successfully/)
      end

      it 'returns an authentication token' do
        expect(json['auth_token']).not_to be_nil
      end
    end

    context 'when invalid request' do
      before { post '/signup', params: {}, headers: headers }

      it 'does not create a new user' do
        expect(response).to have_http_status(422)
      end

      it 'returns failure message' do
        expect(json['message'])
          .to match(/Validation failed: Password can't be blank, Name can't be blank, Email can't be blank, Password digest can't be blank/)
      end
    end
  end

  # ---------- GET /me ----------
  describe 'GET /me' do
    let!(:current_user) { create(:user) }
    let(:auth_headers)  do
      valid_headers.merge('Authorization' => token_generator(current_user.id))
    end

    context 'when token is valid' do
      before { get '/me', headers: auth_headers }

      it 'returns status 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns current user without password_digest' do
        expect(json['id']).to eq(current_user.id)
        expect(json).not_to have_key('password_digest')
      end
    end

    context 'when token is missing' do
      before { get '/me', headers: headers } # no Authorization

      it 'returns 422 or 401' do
        expect([401, 422]).to include(response.status)
      end

      it 'returns error message' do
        expect(json['message']).to match(/Missing token|Invalid token|Unauthorized/i)
      end
    end
  end


end