# Doomhub.com

[![Code Climate](https://codeclimate.com/github/ellmo/doomhub.png)](https://codeclimate.com/github/ellmo/doomhub)

This is the primary repository of the new [Doomhub.com](http://doomhub.com) project.
Old repository (using Rails3 and Backbone.js is [here](https://github.com/ellmo/doomhub-old)

Doomhub is a Doom community web application for managing and sharing various doom-engine based projects.

## basic development information
* platform used: Ruby on Rails (4.1.1)
* language used: MRI Ruby (2.1.1)
* frontend framework used: AngularJS (1.2.18)
* database used: PostgreSQL (9.2.1)

## basic testing information
* Rails backend tested using Minitest + Guard
* Requires NodeJS (v0.10.24) and NPM (1.3.21) to perform JS tests
* Angular.js frontend tested using PhantomJS, Karma and Protractor


### running tests

Before running Rails backend tests make sure `bundle install` succeeds and test database is up to date (`bundle exec rake db:test:clone_structure` to force it)

* `bundle exec rake test` to perform a full backend test (single-run)
* `bundle exec guard` to start a backend testing loop

Before running Javascript tests make sure `npm install` succeeds

* `bundle exec rake karma:run` to perform a full frontend test (single-run)
* `bundle exec rake karma:start` to start a frontend testing loop
