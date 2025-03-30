class CreateAnimals < ActiveRecord::Migration[7.0]
  def change
    create_table :animals, id: false do |t|
      t.string :name, primary_key: true
      t.timestamps
    end
  end
end 