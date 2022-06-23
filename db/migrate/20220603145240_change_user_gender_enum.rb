class ChangeUserGenderEnum < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :gender, :integer, using: 'gender::integer'
  end
end
