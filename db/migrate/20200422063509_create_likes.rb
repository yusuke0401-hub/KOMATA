class CreateLikes < ActiveRecord::Migration[5.0]
  def change
    create_table :likes do |t|
      t.references :otasuke_message, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
      
      t.index [:user_id, :otasuke_message_id], unique: true
    end
  end
end
