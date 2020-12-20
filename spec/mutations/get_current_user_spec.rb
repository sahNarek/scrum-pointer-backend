# require 'rails_helper'
# require_relative '../support/query_helpers'

# RSpec.describe Queries::GetCurrentUser type: :request do 
#   describe "#resolce" do
#     context "When the token is valid" do
#       let(:user){create(:user)}
#       let(:json_reponse){JSON.parse(response.body)['data']}
#       let(:token){json_reponse['userSignIn']['token']}

#       before do
#         post '/api/v1/graphql', params: {query: QueryHelpers::sign_in(token)}
#         # post '/api/v1/graphql', params: {query: QueryHelpers::get_current_user(token)}
#       end

#       it '' do
        
#       end

#     end
#   end
# end