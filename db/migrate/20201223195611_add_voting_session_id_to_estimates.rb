class AddVotingSessionIdToEstimates < ActiveRecord::Migration[6.0]
  def change
    add_reference :estimates, :voting_session, null: false, foreign_key: true
  end
end
