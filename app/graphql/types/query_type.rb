module Types
  class QueryType < Types::BaseObject
    field :user, resolver: Queries::GetUser
    field :get_voter_estimates, resolver: Queries::GetVoterEstimates
    field :current_user, resolver: Queries::GetCurrentUser
    field :current_voter, resolver: Queries::GetCurrentVoter
    field :voting_session, resolver: Queries::GetVotingSession
    field :ticket, resolver: Queries::GetTicket
  end
end
