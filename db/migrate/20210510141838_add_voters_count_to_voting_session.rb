class AddVotersCountToVotingSession < ActiveRecord::Migration[6.0]
  def change
    add_column :voting_sessions, :voters_count, :integer
  end
end
