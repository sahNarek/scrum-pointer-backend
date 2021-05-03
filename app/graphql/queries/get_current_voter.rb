module Queries
  class GetCurrentVoter < Queries::BaseQuery

    type Types::VoterType, null: true

    def resolve()
      #TODO Write tests 
      context[:current_voter]
    end
    
  end
end