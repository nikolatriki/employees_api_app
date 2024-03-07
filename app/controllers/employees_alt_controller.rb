class EmployeesAltController < ApplicationController
  def api_index
    @employees = EmployeeApiAlt.employee_list
  end
end
