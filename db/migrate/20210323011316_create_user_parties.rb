class CreateUserParties < ActiveRecord::Migration[5.2]
  def change
    create_table :user_parties do |t|
      t.references :user, foreign_key: true
      t.references :party, foreign_key: true
      t.integer :user_status

      t.timestamps
    end
  end
end
