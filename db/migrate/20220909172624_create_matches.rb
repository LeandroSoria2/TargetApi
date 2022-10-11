class CreateMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :matches do |t|
      t.belongs_to :target, null: false
      t.references :compatible_target, index: true, foreign_key: { to_table: :targets }

      t.timestamps
    end
  end
end
