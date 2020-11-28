class CreateSessions < ActiveRecord::Migration[6.0]
  def up
    create_table :sessions do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :name
      t.integer :voters_count
      t.integer :voting_duration

      t.timestamps
    end
  end

  def down
    drop_table :sessions
  end
end
