Rails.application.routes.draw do
  resources :users do
    collection do
      post 'login'
      delete 'logout'
    end
  end
  resources :courses

  resources :students
  resources :employees
  root to: 'students#index'
end
