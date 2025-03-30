class AddNoiseToAnimals < ActiveRecord::Migration[7.0]
  def change
    add_column :animals, :noise, :string, null: false
  end
end 