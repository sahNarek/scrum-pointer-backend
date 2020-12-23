class CreateEstimates < ActiveRecord::Migration[6.0]
  def change
    create_table :estimates do |t|
      t.belongs_to :voter, null: false, foreign_key: true
      t.belongs_to :ticket, null: false, foreign_key: true
      t.numeric :point
      t.boolean :final_estimate, null: false, default: false

      t.timestamps
    end
  end
end
