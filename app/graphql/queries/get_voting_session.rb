module Queries
  class GetVotingSession < Queries::BaseQuery

    argument :id, ID, required: true
    type Types::VotingSessionType, null: true

    def resolve(id:)
      VotingSession.find(id)
    end

  end
end