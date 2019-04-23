Rails.application.routes.draw do
  resources :shifts
  resources :schools do 
    resources :employees do
      resources :shifts
    end
  end
  resources :roles do 
    resources :employees
  end
  post 'employee_uid' => 'employee_token#validate_uid'
  post 'employee_login' => 'employee_token#validate_password'
  post 'find_employee' => 'employees#show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
