require "net/http"
require "json"

module EmployeeApiAlt
  BASE_URL = "https://beta.01cxhdz3a8jnmapv.com/api/v1/assignment/"

  def self.employee_list
    access_token = generate_access_token
    uri = URI("#{BASE_URL}employee/list")

    request = Net::HTTP::Get.new(uri.path)
    request["Authorization"] = "Bearer #{access_token}"

    response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    parse_response(response)
  end

  private_class_method

  def self.generate_access_token
    return @access_token if @access_token

    uri = URI("#{BASE_URL}token/")

    request = Net::HTTP::Post.new(uri.path)
    request.body = user_load
    request["Content-Type"] = "application/json"

    response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    @access_token = JSON.parse(response.body)["access_token"]
  end

  def self.user_load
    {
      grant_type: ENV['GRANT_TYPE'],
      client_id: ENV['CLIENT_ID'],
      client_secret: ENV['CLIENT_SECRET'],
      username: ENV['USER_NAME'],
      password: ENV['PASSWORD']
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
