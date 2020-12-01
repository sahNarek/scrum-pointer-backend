require 'rails_helper'

module Mutations
  RSpec.describe UserSignUp, type: :request do
    describe '.resolve' do
      it 'Creates a new user' do
        user = build(:user)
        post '/api/v1/graphql', params: {query: signup_query(user: user)}
        json = JSON.parse(response.body)
        errors = json['data']['userSignUp']['errors']

        expect(errors).to match_array([])
      end
    end

    def signup_query(user:)
      <<~GQL
      mutation{
        userSignUp(input:{
          email: "#{user.email}"
          firstName: "#{user.first_name}"
          lastName: "#{user.last_name}"
          password: "#{user.password}"
          passwordConfirmation: "#{user.password_confirmation}"
        }){
          user{
            id
            firstName
            lastName
            email
          }
          errors
        }
      }
      GQL
    end
  end
end
