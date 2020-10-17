class ChangeHighestRateOfUsers < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :highest_rate, :integer, default: 0
  end
end
