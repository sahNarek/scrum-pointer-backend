require 'rails_helper'
require_relative '../support/query_helpers'

RSpec.describe Queries::GetUser, type: :request do 
  describe '#resolve' do
    context 'when a user is signed in' do
      let(:user){create(:user)}
      let(:json_response){JSON.parse(response.body)['data']}

      before do
        post '/api/v1/graphql', params: {query: QueryHelpers::get_user(id: user.id)}
      end

      it "gets the current user's credentials" do
        created_user = json_response['user']
        expect(created_user).to include(
          "id" => be_present,
          "email" => user.email,
          "firstName" => user.first_name,
          "lastName" => user.last_name
        )
      end
    end
  end
end