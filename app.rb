require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'json'

require './migrations'
require './employee'
require './development'


before do
  content_type 'application/json'
end

get '/employee' do
  Employee.all.to_json
end

get '/employee/:id' do
  employee = Employee.find(params["id"])
  employee.to_json
end

post '/employee' do
  payload = JSON.parse(request.body.read)
  employee = Employee.create(payload)
  employee.to_json
end

delete '/employee/:id' do
  employee = Employee.find(params["id"])
  employee.destroy!
end
