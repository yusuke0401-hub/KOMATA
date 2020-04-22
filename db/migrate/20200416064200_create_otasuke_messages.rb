class CreateOtasukeMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :otasuke_messages do |t|
      t.string :content
      t.references :user, foreign_key: true
      t.references :komata_message, foreign_key: true
      
      t.timestamps
    end
  end
end
