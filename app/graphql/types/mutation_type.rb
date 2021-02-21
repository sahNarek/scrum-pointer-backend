module Types
  class MutationType < Types::BaseObject
    field :user_sign_up, mutation: Mutations::UserSignUp
    field :user_sign_in, mutation: Mutations::UserSignIn
    field :create_voting_session, mutation: Mutations::CreateVotingSession
    field :create_ticket, mutation: Mutations::CreateTicket
    field :create_estimate, mutation: Mutations::CreateEstimate
    field :join_as_voter, mutation: Mutations::JoinAsVoter
  end
end
