class EmployeesController < ApplicationController
  before_action :populate_employees, only: [:index]

  def index
    @employees = Employee.all
  end

  private

  def populate_employees
    EmployeeApi.employee_list
  end
end
