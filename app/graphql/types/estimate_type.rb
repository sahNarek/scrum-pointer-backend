module Types
  class EstimateType < Types::BaseObject
    field :id, ID, null: false
    field :ticket_id, ID, null: false
    field :voter_id, ID, null: false
    field :point, Numeric, null: false
  end
end