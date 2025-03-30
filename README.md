rails new demo-ruby-classes-rails-api --skip-turbolinks --skip-javascript --skip-coffee --skip-sprockets --skip-yarn --skip-action-cable --skip-git

// For animals:
{
  "animal": {
    "name": "lion"
  }
}

// For foods:
{
  "food": {
    "name": "apple"
  }
}


# Just run the seeds
rails db:seed

# Or, if you want to reset the database and run seeds
rails db:reset    # This drops the database, recreates it, runs migrations, and then seeds

# Or, if setting up for the first time
rails db:setup    # This creates the database, loads the schema, and runs seeds


# create animal and food relationships

curl -X POST http://localhost:3000/animals \
  -H "Content-Type: application/json" \
  -d '{
    "animal": {
      "name": "Duck",
      "noise": "quack",
      "foods": ["Seed"]
    }
  }'

