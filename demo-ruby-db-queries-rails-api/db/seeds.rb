# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Clear existing data
puts "Cleaning database"
ProviderClientPlan.destroy_all
Journal.destroy_all
Provider.destroy_all
Client.destroy_all
Plan.destroy_all

puts "Creating plans"
basic = Plan.create!(name: "basic")
premium = Plan.create!(name: "premium")
puts "Created #{Plan.count} plans"

puts "Creating providers"
providers = 5.times.map do |i|
  Provider.create!(
    name: "Provider #{i + 1}",
    email: "provider#{i + 1}@example.com"
  )
end
puts "Created #{Provider.count} providers"

puts "Creating clients"
clients = 25.times.map do |i|
  Client.create!(
    name: "Client #{i + 1}",
    email: "client#{i + 1}@example.com"
  )
end
puts "Created #{Client.count} clients"

puts "Creating journals"
clients.each do |client|
  5.times do |i|
    Journal.create!(
      client: client,
      text: "Journal entry #{i + 1} for #{client.name}. Random text: #{SecureRandom.hex(50)}"
    )
  end
end
puts "Created #{Journal.count} journals"

puts "Creating provider-client-plan relationships"

# Assign 20 clients to a single random provider with a random plan
clients[0..19].each do |client|
  ProviderClientPlan.create!(
    provider: providers.sample,
    client: client,
    plan_name: [basic.name, premium.name].sample
  )
end

# Assign remaining 5 clients to multiple providers
remaining_clients = clients[20..24]
provider_counts = [0, 1, 2, 3, 4, 5]

remaining_clients.each_with_index do |client, index|
  provider_count = provider_counts[index]
  
  # Randomly select providers for this client
  selected_providers = providers.sample(provider_count)
  
  # Create relationships for each selected provider
  selected_providers.each do |provider|
    ProviderClientPlan.create!(
      provider: provider,
      client: client,
      plan_name: [basic.name, premium.name].sample
    )
  end
end

puts "Created #{ProviderClientPlan.count} provider-client-plan relationships"

puts "Seeding completed"
