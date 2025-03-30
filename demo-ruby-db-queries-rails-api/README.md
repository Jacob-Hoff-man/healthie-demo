# Demo - Ruby Database Model And Queries

### Problem Description

We want to model providers (e.g. dietitians), their clients, and journal entries.
- Both providers and clients have a name and an email address.
- Providers have many clients
- Clients usually have one Provider but can have more than one.
- Clients have a plan that they paid for, signified by the string "basic" or "premium". For each
provider that a client is signed up with, they have 1 plan.
- Clients post journal entries. These consist of freeform text.

We want to be able to do these queries:
- Find all clients for a particular provider
- Find all providers for a particular client
- Find all of a particular client's journal entries, sorted by date posted
- Find all of the journal entries of all of the clients of a particular provider, sorted by date posted

Using ActiveRecord, create the classes and schema migrations for this, including indexes.

If possible, please use sqlite for your database.

Show how to do each of the queries listed above.

If you are torn between multiple approaches, just choose one to implement and explain the other approach and what the pros and cons of each might be.

### Problem Solution

TODO

## How To Run

- In a terminal, traverse to the `demo-ruby-db-queries-rails-api` directory
    - Run `rails db:migrate` to run migrations.
    - Run `rails db:seed` to run seeds.
    - Run `rails server` to locally deploy the API.
    - Access the API at `http://localhost:3000`.

### Other

- Ruby on Rails project created using the following command:
```
rails new demo-ruby-db-queries-rails-api --skip-turbolinks --skip-javascript --skip-coffee --skip-sprockets --skip-yarn --skip-action-cable --skip-git
```

- Generate API spec:
```
rails generate rswag:api:install && rails generate rswag:ui:install
```
