require "test_helper"
require "minitest/mock"

class EmployeesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_url
    assert_response :success
  end

  test "should populate employees" do
    mock = Minitest::Mock.new
    mock.expect(:employee_list, nil)

    EmployeeApi.stub(:employee_list, mock.employee_list) do
      get root_url
      assert_equal Employee.count, @response.body.scan("2024-03-05").count
    end

    mock.verify
  end
end
