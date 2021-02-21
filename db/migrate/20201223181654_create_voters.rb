class CreateVoters < ActiveRecord::Migration[6.0]
  def change
    create_table :voters do |t|
      t.string :name
      t.belongs_to :voting_session, null: false, foreign_key: true

      t.timestamps
    end
  end
end
