require 'rails_helper'
require_relative '../support/query_helpers'

RSpec.describe Mutations::UserSignIn, type: :request do
  describe '#resolve' do
    context 'when the log in credentials are correct' do
      let(:user){create(:user)}
      let(:json_response){JSON.parse(response.body)['data']}

      before do 
        post '/api/v1/graphql', params: {query: QueryHelpers::sign_in(user: user)}
      end

      it 'generates a token' do
        token = json_response['userSignIn']['token']
        expect(token).to be_present
      end

      it 'expires the token in future' do
        exp_time = json_response['userSignIn']['expTime']
        exp_date = Date.strptime(exp_time, "%m-%d-%Y %H:%M")
        expiry_check =  exp_date > Date.today ? true : false
        expect(expiry_check).to eq(true)
      end

      it 'retrieves correct credentials for user' do
        created_user = json_response['userSignIn']['user']
        expect(created_user).to include(
          "id" => be_present,
          "email" => user.email,
          "firstName" => user.first_name,
          "lastName" => user.last_name
        )
      end

    context 'when the user credentials are wrong' do
      let(:user){build_stubbed(:user)}
      let(:json_response){JSON.parse(response.body)['data']}

      before do 
        post '/api/v1/graphql', params: {query: QueryHelpers::sign_in(user: user)}
      end

      it 'gets wrong credentials error message' do
        errors = json_response['userSignIn']['errors']
        expect(errors).to match_array([I18n.t('wrong_credentials')])
      end

      it 'does not generate a token' do 
        token = json_response['userSignIn']['token']
        expect(token).to be nil
      end
    end

    end
  end
end