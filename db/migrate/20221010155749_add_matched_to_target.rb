class AddMatchedToTarget < ActiveRecord::Migration[7.0]
  def change
    add_column :targets, :matched, :bool, null: false, default: false
  end
end
