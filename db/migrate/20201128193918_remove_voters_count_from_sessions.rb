class RemoveVotersCountFromSessions < ActiveRecord::Migration[6.0]
  def up
    remove_column :sessions, :voters_count
  end

  def down
    add_column :sessions, :voters_count, :integer
  end
end
