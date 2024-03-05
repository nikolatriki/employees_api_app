require "test_helper"

class EmployeeTest < ActiveSupport::TestCase
  test "full_name returns the correct full name" do
    employee = Employee.new(first_name: "John", last_name: "Doe")
    assert_equal "John Doe", employee.full_name
  end
end
