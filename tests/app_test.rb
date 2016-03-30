require "./tests/test_helper"



class AppTest < Minitest::Unit::TestCase
  include Rack::Test::Methods

  def setup
    begin CompanyDataMigration.migrate(:down); rescue; end
    CompanyDataMigration.migrate(:up)
  end

  def app
    Sinatra::Application
  end

  def test_students_returns_a_list_of_students
    new_employee = Employee.create(name: "Dan", email: "d@mail.com", phone: "914-555-5555", salary: 50000.00)
    get "/employee"
    json_response = JSON.parse(last_response.body)
    assert_equal true, json_response.first.has_key?("id")
  end

  def test_can_read_single_employee
    new_employee = Employee.create(name: "Dan", email: "d@mail.com", phone: "914-555-5555", salary: 50000.00)
    get "/employee/#{new_employee.id}"
    employee = JSON.parse(last_response.body)
    assert_equal "Dan", employee["name"]
  end

  def test_can_create_new_employee
    hash = { name: 'bob' }
    response = post("/employee", hash.to_json, { "CONTENT_TYPE" => "application/json" })
    new_employee = JSON.parse(response.body)
    assert_equal "bob", new_employee["name"]
  end

  def test_can_delete_employee
    new_employee = Employee.create(name: "Dan", email: "d@mail.com", phone: "914-555-5555", salary: 50000.00)
    delete "/employee/#{new_employee.id}"
    response = last_response.body
    assert_equal "", response
    assert_equal false, Employee.exists?(new_employee.id)
  end

  def test_can_change_employees_name
    new_employee = Employee.create!(name: "Dan", email: "d@mail.com", phone: "914-555-5555", salary: 50000.00)
    hash = { name: "Mike" }
    response = patch("/employee/#{new_employee.id}", hash.to_json)
    name_change = JSON.parse(response.body)
    assert_equal "Mike", name_change["name"]
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
