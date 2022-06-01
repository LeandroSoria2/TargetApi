class ChangeUserEmailNotNull < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :email, :string, null: false
  end
end
