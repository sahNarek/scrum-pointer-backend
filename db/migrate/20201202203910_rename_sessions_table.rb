class RenameSessionsTable < ActiveRecord::Migration[6.0]
  def up
    rename_table :sessions, :voting_sessions
  end

  def down
    rename_table :voting_sessions, :sessions
  end
end
