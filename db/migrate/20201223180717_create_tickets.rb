class CreateTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets do |t|
      t.string :name
      t.boolean :estimated, default: false
      t.belongs_to :voting_session, null: false, foreign_key: true

      t.timestamps
    end
  end
end
