class CreateParties < ActiveRecord::Migration[5.2]
  def change
    create_table :parties do |t|
      t.datetime :date
      t.references :movie, foreign_key: true
      t.string :duration

      t.timestamps
    end
  end
end
