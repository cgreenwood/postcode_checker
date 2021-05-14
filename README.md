# README

## Setup

### System dependencies

Please ensure you have the right versions of the following installed:
- Ruby version - `2.6.5`
- Ruby on Rails version - `6.1.3.2`

### Steps for setup

1) Install the correct version of ruby using these  [instructions](https://www.ruby-lang.org/en/documentation/installation/)
2) `$ gem install bundler -v 2.2.17`
3) `$ gem install rails -v '6.1.3.2'`
4) `$ bundle install`
5) `$ rails s`
6) Go to [http://localhost:3000](http://localhost:3000)

## Testing

### Unit Testing

Tests are written using RSpec, to run them use the following command:
`$ rspec spec/`

### Acceptance Testing

Tests are written using Cucumber/Capybara, to run them use the following command:
`$ bundle exec cucumber features/`
