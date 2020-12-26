module Types
  class QueryType < Types::BaseObject
    field :user, resolver: Queries::GetUser
    field :current_user, resolver: Queries::GetCurrentUser
    field :voting_session, resolver: Queries::GetVotingSession
    field :ticket, resolver: Queries::GetTicket
  end
end
