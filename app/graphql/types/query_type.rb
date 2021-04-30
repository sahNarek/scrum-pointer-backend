module Types
  class QueryType < Types::BaseObject
    field :user, resolver: Queries::GetUser
    field :get_voter_estimates, resolver: Queries::GetVoterEstimates
    field :current_user, resolver: Queries::GetCurrentUser
    field :voting_session, resolver: Queries::GetVotingSession
    field :ticket, resolver: Queries::GetTicket
  end
end
