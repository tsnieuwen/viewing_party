class AddHostIdToParties < ActiveRecord::Migration[5.2]
  def change
    add_column :parties, :host_id, :integer
  end
end
