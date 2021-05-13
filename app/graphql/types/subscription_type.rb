module Types
  class SubscriptionType < BaseObject
    field :estimate_added_to_ticket, Types::EstimateType, null: false do
      argument :ticket_id, ID, required: true
    end

    field :ticket_added_to_voting_session, Types::TicketType, null: false do
      argument :voting_session_id, ID, required: true
    end

    field :voter_joined_voting_session, Types::VotingSessionType, null: false do
      argument :voting_session_id, ID, required: true
    end

    def ticket_added_to_voting_session(voting_session_id:)
      object
    end

    def estimate_added_to_ticket(ticket_id:)
      object
    end

    def voter_joined_voting_session(voting_session_id:)
      object
    end
  end
end