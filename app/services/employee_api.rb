require "net/http"
require "json"

module EmployeeApi
  BASE_URL = "https://beta.01cxhdz3a8jnmapv.com/api/v1/assignment/"

  def self.employee_list
    Rails.cache.fetch("employee.list", expires_in: 2.hours) do
      access_token = generate_access_token
      uri = URI("#{BASE_URL}employee/list")

      request = Net::HTTP::Get.new(uri.path)
      request["Authorization"] = "Bearer #{access_token}"

      response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        http.request(request)
      end

      employees = parse_response(response)

      Employee.delete_all

      employees.each do |employee|
        Employee.create!(
          first_name: employee["first_name"],
          last_name: employee["last_name"],
          email: employee["email"],
          address: employee["address"],
          country: employee["country"],
          bio: employee["bio"],
          rating: employee["rating"],
          date_of_birth: employee["date_of_birth"]
        )
      end
    end
  end

  private_class_method

  def self.generate_access_token
    uri = URI("#{BASE_URL}token/")

    request = Net::HTTP::Post.new(uri.path)
    request.body = user_load
    request["Content-Type"] = "application/json"

    response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    JSON.parse(response.body)["access_token"]
  end

  def self.user_load
    {
      grant_type: "password",
      client_id: "6779ef20e75817b79605",
      client_secret: "3e0f85f44b9ffbc87e90acf40d482602",
      username: "hiring",
      password: "tmtg"
    }.to_json
  end

  def self.parse_response(response)
    case response
    when Net::HTTPSuccess
      JSON.parse(response.body)
    else
      # Handle error response
      {error: response.message}
    end
  end
end
