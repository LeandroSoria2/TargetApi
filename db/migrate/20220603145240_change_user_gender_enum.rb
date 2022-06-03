class ChangeUserGenderEnum < ActiveRecord::Migration[7.0]
  def up
    execute "ALTER TABLE users ALTER gender DROP DEFAULT;"
    change_column :users, :gender, :integer, using: 'gender::integer', default: 0
  end
end
