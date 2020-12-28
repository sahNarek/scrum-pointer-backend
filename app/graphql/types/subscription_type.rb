module Types
  class SubscriptionType < BaseObject
    field :estimate_added_to_ticket, Types::EstimateType, null: false do
      argument :ticket_id, ID, required: true
    end

    def estimate_added_to_ticket(ticket_id:)
      object
    end
  end
end