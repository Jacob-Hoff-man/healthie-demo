# Demo - Ruby Classes (API Variation)

### Problem Description

Create classes Cat, Dog, Chicken, CatFood, DogFood, HumanFood, Lemon, Milk
- a cat likes CatFood, Chicken, and Milk
- a dog likes DogFood, CatFood, Chicken, HumanFood
- a Cat can meow and a Dog can bark (print "meow" or "bark" to STDOUT)
- when an animal eats food it likes, it makes a noise three times
- when an animal eats food it dislikes, it makes a noise one time
You can implement this any way you like, with whatever api you think makes sense.
Include a driver file which requires the files, instantiates the classes, and invokes the methods to
demonstrate the functionality.

### Problem Solution

- A database approach is used with Ruby On Rails instead of polymorphism and classes in Ruby.
    - The project utilizes the built-in SQLite local database.
    - MVC pattern is used:
        - Models represent data/tables in the db and utilize Active Records for interfacing with the db.
        - Services contain encapsulated business logic.
        - Controllers handle incoming web requests (e.g. Curl API request) and are mapped to routes defined in `/config/routes.rb`.
- An `Animal` entity is defined to store animal name and noise.
- A `Food` entity is defined to store food name.
- An `AnimalLikesFood` relational entity is defined to store the many-to-many relationship between `Food` and `Animal` records.

## How To Run

- In a terminal, traverse to the `demo-ruby-classes-rails-api` directory
    - Run `rails db:migrate` to run migrations.
    - Run `rails db:seed` to run seeds.
    - Run `rails server` to locally deploy the API.
    - Access the API at `http://localhost:3000`.

- Sample curl requests:
```
# Create `Animal` and liked `Foods` (creates `Food` records if dne and creates `AnimalLikesFood` records):

curl -X POST http://localhost:3000/animals \
  -H "Content-Type: application/json" \
  -d '{
    "animal": {
      "name": "Duck",
      "noise": "quack",
      "foods": ["Seed"]
    }
  }'
```
```
# Create `Animal` record:

curl -X POST http://localhost:3000/animals \
  -H "Content-Type: application/json" \
  -d '{
    "animal": {
      "name": "Duck",
      "noise": "quack"
    }
  }'
```
```
# Create `Food` record:

curl -X POST http://localhost:3000/foods \
  -H "Content-Type: application/json" \
  -d '{
    "food": {
      "name": "Cheese"
    }
  }'
```
```
# List all `Animal` records:

curl http://localhost:3000/animals
```
```
# List all `Food` records:

curl http://localhost:3000/foods
```
```
# List all `Food` records that are liked by an `Animal` record:

curl http://localhost:3000/animals/:animal_name/foods
```
```
# List all `Animal` records that like a `Food` record:

curl http://localhost:3000/foods/:food_name/animals
```
```
# return `Animal.noise` three times if given `Animal` record likes given `Food` record, one time if does not like, and return not found if either record dne:

curl http://localhost:3000/animals/:animal_name/foods/:food_name
```

### Other

- Ruby on Rails project created using the following command:
```
rails new demo-ruby-classes-rails-api --skip-turbolinks --skip-javascript --skip-coffee --skip-sprockets --skip-yarn --skip-action-cable --skip-git
```