module Types
  class EstimateType < Types::BaseObject
    field :id, ID, null: false
    field :ticket_id, ID, null: false
    field :voter_id, ID, null: false
    field :point, Integer, null: false
    field :voter, Types::VoterType, null: false
    field :final_estimate, Boolean, null: false
  end
end