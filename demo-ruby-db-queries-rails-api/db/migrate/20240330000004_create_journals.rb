class CreateJournals < ActiveRecord::Migration[7.1]
  def change
    create_table :journals do |t|
      t.references :client, null: false, foreign_key: true
      t.text :text, null: false
      t.timestamps
    end
  end
end 