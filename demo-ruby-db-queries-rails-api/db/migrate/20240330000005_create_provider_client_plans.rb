class CreateProviderClientPlans < ActiveRecord::Migration[7.1]
  def change
    create_table :provider_client_plans do |t|
      t.references :provider, null: false, foreign_key: true
      t.references :client, null: false, foreign_key: true
      t.string :plan_name, null: false
      t.timestamps

      t.foreign_key :plans, column: :plan_name, primary_key: :name
      t.index [:provider_id, :client_id], unique: true, name: 'idx_provider_client_unique'
    end
  end
end 