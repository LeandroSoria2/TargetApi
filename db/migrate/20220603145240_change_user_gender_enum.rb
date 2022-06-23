class ChangeUserGenderEnum < ActiveRecord::Migration[7.0]
  def up
    change_column :users, :gender, :integer, using: 'gender::integer'
  end

  def down
    change_column :users, :gender, :string
  end
end
