class ChangeDateToString < ActiveRecord::Migration[5.2]
  def change
    change_column :parties, :date, :string
  end
end
