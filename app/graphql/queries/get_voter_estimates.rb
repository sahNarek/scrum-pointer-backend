module Queries
  class GetVoterEstimates < Queries::BaseQuery

    argument :voter_id, ID, required: true
    argument :ticket_id, ID, required: true

    type [Types::EstimateType], null: true

    def resolve(ticket_id:, voter_id:)
      Ticket.find(ticket_id).estimates.where(voter_id: voter_id)
    end
  end
end