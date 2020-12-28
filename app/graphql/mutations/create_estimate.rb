module Mutations
  class CreateEstimate < Mutations::BaseMutation
    argument :voter_id, ID, required: true
    argument :ticket_id, ID, required: true
    argument :voting_session_id, ID, required: true
    argument :point, Integer, required: true

    field :estimate, Types::EstimateType, null: false
    field :errors, [String], null: true

    def resolve(voter_id:, ticket_id:, voting_session_id:, point:)
      estimate = Estimate.new(
        voter_id: voter_id, voting_session_id: voting_session_id, ticket_id: ticket_id, point: point
      )

      if estimate.valid?
        estimate.save!
        # ScrumPointerBackend.subscriptions.trigger(:estimate_added_to_ticket, { ticket_id: ticket_id }, estimate)
        {
          estimate: estimate,
          errors: []
        }
      else
        begin
          estimate.validate!
        rescue ActiveRecord::RecordInvalid
          errors = estimate.errors.full_messages
        end
        {
          estimate: nil,
          errors: errors
        }
      end

    end

  end
end