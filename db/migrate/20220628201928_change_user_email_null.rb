class ChangeUserEmailNull < ActiveRecord::Migration[7.0]
  def up
    change_column :users, :email, :string
  end

  def down
    change_column :users, :email, :string, null: false
  end
end
