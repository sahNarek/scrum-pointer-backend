require 'rails_helper'
require_relative '../support/query_helpers'

RSpec.describe Mutations::UserSignUp, type: :request do
  describe '#resolve' do
    context 'when the user credentials are correct' do 
      let(:user){ build_stubbed(:user)}
      let(:json_response){ JSON.parse(response.body)['data'] }

      before do 
        post '/api/v1/graphql', params: {query: QueryHelpers::sign_up(user: user)}
      end

      it 'creates a new user without errors' do
        errors = json_response['userSignUp']['errors']
        expect(errors).to match_array([])
      end
  
      it 'saves correct information' do
        created_user = json_response['userSignUp']['user']
        expect(created_user).to include(
          "id" => be_present,
          "email" => user.email,
          "firstName" => user.first_name,
          "lastName" => user.last_name
        )
      end
    end

    context 'when the user\'s credentials are wrong' do
      let(:user){ build_stubbed(:user)}
      let(:json_response){ JSON.parse(response.body)['data'] }

      before do 
        user.password_confirmation = '12344444'
        post '/api/v1/graphql', params: {query: QueryHelpers::sign_up(user: user)}
      end

      it 'shows an error' do
        errors = json_response['userSignUp']['errors']
        expect(errors).to match_array(["Password confirmation doesn't match Password"])
      end

      it 'does not create a user' do
        created_user = json_response['userSignUp']['user']
        expect(created_user).to be nil
      end

    end

  end
end
