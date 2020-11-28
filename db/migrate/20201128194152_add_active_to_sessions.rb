class AddActiveToSessions < ActiveRecord::Migration[6.0]
  def up
    add_column :sessions, :active, :boolean
  end

  def down
    remove_column :sessions, :active
  end
end
