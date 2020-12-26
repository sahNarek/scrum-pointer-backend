module Mutations
  class JoinAsVoter < Mutations::BaseMutation
    argument :voting_session_id, ID, required: true
    argument :name, String, required: true

    field :voter, Types::VoterType, null: false
    field :errors, [String], null: false

    def resolve(voting_session_id:, name:)
      voting_session = VotingSession.find(voting_session_id)
      unless voting_session&.voters.find_by(name: name).nil?
        {
          voter: voting_session&.voters.find_by(name: name),
          errors: []
        }
      else
        voter = Voter.new(
          voting_session_id: voting_session_id, name: name
        )
        voter.save!
        {
          voter: voter,
          errors: []
        }
      end
    end

  end
end