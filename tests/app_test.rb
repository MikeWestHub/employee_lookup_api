require "./tests/test_helper"

class AppTest < Minitest::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_students_returns_a_list_of_students
    get '/employee'
    json_response = JSON.parse(last_response.body)
    assert_equal true, json_response.first.has_key?("id")
  end

  def test_can_read_single_employee
    get '/employee/8'
    employee = JSON.parse(last_response.body)
    assert_equal "Elanor", employee["name"]
  end
  # def test_it_says_hello_world
  #   get '/'
  #   assert last_response.ok?
  #   assert_equal 'I am Groot', last_response.body
  # end
  #
  # def test_it_says_hello_to_a_person
  #   get '/', :name => 'Simon'
  #   assert last_response.body.include?('Groot')
  #   assert_equal 'I am Groot', last_response.body
  # end

end
