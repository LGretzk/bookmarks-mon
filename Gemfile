# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

ruby '3.0.2'



group :test do
  gem 'capybara'
  gem 'rspec'
  gem 'simplecov', require: false
  gem 'simplecov-console', require: false
  gem 'rubocop', '1.20'
end

group :development, :test, :deployment do
  gem 'sinatra'
  gem 'webrick'
  gem 'sinatra-contrib'
  gem 'rack'
  gem 'launchy'
  gem 'pg'
  gem 'sinatra-flash'
end
