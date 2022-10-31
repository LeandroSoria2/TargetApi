class CreateConversations < ActiveRecord::Migration[7.0]
  def change
    create_table :create_conversations do |t|
      t.belongs_to :match, foreign_key: true
      t.timestamps
    end

    create_table :user_conversations do |t|
      t.belongs_to :user, index: true
      t.belongs_to :conversation, index: true

      t.timestamps
    end
  end
end
