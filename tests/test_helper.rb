ENV["RACK_ENV"] = "test"

require 'minitest'
require 'minitest/autorun'
require 'rack/test'
require 'sinatra'

require "./app"

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'test.sqlite3'
)
ActiveRecord::Migration.verbose = false
