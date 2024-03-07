Rails.application.routes.draw do
  root "employees#index"
  get "employees_alt", to: "employees_alt#api_index"
end
