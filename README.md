# Simple Pokedex App

Backed by [PokeApi](https://pokeapi.co/)

https://jays-pokedex.herokuapp.com/

## TODO
- Add test coverage / refactor
- Add cron job to sync pokemon/types daily with pokeapi
- Add additional regions

## Setup For Development
- clone the project
- `cd /path/to/git/dir`
- `bundle install`
- `yarn install`
- `rails db:create`
- `rails db:migrate`
- `rails db:seed`

## Testing
- run `rspec` to run the full test suite. Note: Test suite is a work in progress so far I only have some feature tests that cover the main functionality of the app

## Tech Stack <3
- Ruby on Rails 6.0
- Postgres
- RSpec 3
- Vue.JS 2.6
- Bootstrap 4
