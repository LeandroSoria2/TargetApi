class ChangeUserEmailNotNull < ActiveRecord::Migration[7.0]
  def up
    change_column :users, :email, :string, null: false
  end

  def down
    change_column :users, :email, :string
  end
end
