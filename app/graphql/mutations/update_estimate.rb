module Mutations
  class UpdateEstimate < Mutations::BaseMutation
    argument :id, ID, required: true
    argument :voter_id, ID, required: false
    argument :ticket_id, ID, required: false
    argument :voting_session_id, ID, required: false
    argument :point, Integer, required: false

    field :estimate, Types::EstimateType, null: true
    field :errors, [String], null: true

    def resolve(id:, **args)
      Estimate.find(id).tap do |estimate|
        estimate.update(args)
      end 
      {
        estimate: Estimate.find(id),
        errors: []
      }
      
    end
  end
end