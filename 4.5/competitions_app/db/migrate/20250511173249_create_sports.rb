class CreateSports < ActiveRecord::Migration[8.0]
  def change
    create_table :sports do |t|
      t.string :name
      t.references :competition, null: false, foreign_key: true

      t.timestamps
    end
  end
end
