module Queries
  class GetCurrentUser < Queries::BaseQuery
  
    type Types::UserType, null: true
    argument :token, String, required: true

    def resolve(token:)
      AuthHelper.find_user_by_token token
    end

  end
end