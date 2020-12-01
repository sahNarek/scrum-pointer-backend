require 'rails_helper'
require_relative '../support/query_helpers'

RSpec.describe Mutations::CreateSession, type: :request do
  describe '#resolve' do
    context 'when a logged in user is creating a session' do
      let(:user){create(:user)}
      let(:json_response){JSON.parse(response.body)['data']}

      before do 
        post '/api/v1/graphql', params: {query: QueryHelpers::create_session(user: user)}
      end

      it 'creates a session by the logged in user' do
        session_user_id = json_response['createSession']['session']['userId']
        expect(session_user_id.to_i).to eq(user.id)
      end

    end

    context 'when a non-authenticated user is creating a session' do
      let(:user){build_stubbed(:user)}
      let(:json_response){JSON.parse(response.body)['data']}

      before do 
        post '/api/v1/graphql', params: {query: QueryHelpers::create_session(user: user)}
      end

      it 'does not create a session' do
        session = json_response['createSession']['session']
        expect(session).to be nil
      end

      it 'shows an error for signing in' do
        errors = json_response['createSession']['errors']
        expect(errors).to match_array([I18n.t('no_user_signed_in')])
      end
      
    end
  end
end