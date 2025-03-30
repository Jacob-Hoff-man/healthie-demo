class CreateAnimalLikesFoods < ActiveRecord::Migration[7.0]
  def change
    create_table :animal_likes_foods do |t|
      t.string :animal_name, null: false
      t.string :food_name, null: false
      t.timestamps

      t.foreign_key :animals, column: :animal_name, primary_key: :name
      t.foreign_key :foods, column: :food_name, primary_key: :name
      t.index [:animal_name, :food_name], unique: true
    end
  end
end 