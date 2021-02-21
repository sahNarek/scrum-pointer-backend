module Queries
  class GetCurrentUser < Queries::BaseQuery
  
    type Types::UserType, null: true

    def resolve()
      #TODO Write tests 
      context[:current_user]
    end

  end
end