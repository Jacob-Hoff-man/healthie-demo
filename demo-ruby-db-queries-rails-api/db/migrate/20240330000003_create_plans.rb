class CreatePlans < ActiveRecord::Migration[7.1]
  def change
    create_table :plans, id: false do |t|
      t.string :name, null: false, primary_key: true
      t.timestamps
    end
  end
end 