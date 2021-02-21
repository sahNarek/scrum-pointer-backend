module Types
  class VoterType < Types::BaseObject
    field :id, ID, null: false
    field :voting_session_id, ID, null: false
    field :name, String, null: false
  end
end