class AddTargetsCountToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :targets_count, :integer
  end
end
