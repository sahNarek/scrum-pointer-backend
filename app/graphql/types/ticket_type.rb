module Types
  class TicketType < Types::BaseObject
    field :id, ID, null: false
    field :voting_session_id, ID, null: false
    field :name, String, null: false
    field :estimated, Boolean, null: false
    field :estimates, [Types::EstimateType], null: false
  end
end