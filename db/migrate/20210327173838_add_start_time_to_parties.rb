class AddStartTimeToParties < ActiveRecord::Migration[5.2]
  def change
    add_column :parties, :start_time, :string
  end
end
