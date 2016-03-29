ENV['RACK_ENV'] = 'test'

require 'minitest'
require 'minitest/autorun'
require 'rack/test'
require 'sinatra'

require "./app"
