module Types
  class VotingSessionType < Types::BaseObject
    field :id, ID, null: false
    field :user_id, ID, null: false
    field :name, String, null: true
    field :voting_duration, Integer, null: true
    field :active, Boolean, null: true
  end
end