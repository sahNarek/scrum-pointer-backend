module Queries
  class GetVoterEstimates < Queries::BaseQuery

    argument :voter_id, ID, required: true
    argument :ticket_id, ID, required: false

    type [Types::EstimateType], null: true

    def resolve(voter_id:,ticket_id:nil)
      unless ticket_id.nil?
        Ticket.find(ticket_id).estimates.where(voter_id: voter_id)
      else 
        Voter.find(voter_id).estimates
      end
      
    end
  end
end