class AddColumnsUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :highest_rate, :integer
  end
end
