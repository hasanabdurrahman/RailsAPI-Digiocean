# spec/requests/v2/todos_spec.rb
require 'rails_helper'

RSpec.describe 'V2::Todos API', type: :request do
  let(:user)   { create(:user) }
  let(:token)  { token_generator(user.id) }
  let(:headers) do
    {
      'Content-Type' => 'application/json',
      'Authorization' => "Bearer #{token}",
      'Accept' => 'application/vnd.todos.v2+json'
    }
  end

  describe 'GET /todos' do
    before { get '/todos', params: {}, headers: headers }

    it 'returns greeting message' do
      expect(json['message']).to eq('Hello there')
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:ok)
    end
  end
end
