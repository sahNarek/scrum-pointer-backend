module Mutations
  class JoinAsVoter < Mutations::BaseMutation
    argument :voting_session_id, ID, required: true
    argument :name, String, required: true

    field :voter, Types::VoterType, null: false
    field :token, String, null: true
    field :exp_time, String, null: true
    field :errors, [String], null: false

    def resolve(voting_session_id:, name:)
      voting_session = VotingSession.find(voting_session_id)
      unless voting_session&.voters.find_by(name: name).nil?
        voter = voting_session&.voters.find_by(name: name)
        payload = AuthHelper::join_as_voter(voter.id)
        context[:current_voter] = AuthHelper::find_voter_by_token payload[:token]
        payload
      else
        voter = Voter.new(
          voting_session_id: voting_session_id, name: name
        )
        voter.save!
        payload = AuthHelper::join_as_voter(voter.id)
        context[:current_voter] = AuthHelper::find_voter_by_token payload[:token]
        payload
      end
    end

  end
end