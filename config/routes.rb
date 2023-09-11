# Rails.application.routes.draw do
#   # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

#   # Defines the root path route ("/")
#   # root "articles#index"
# end


Rails.application.routes.draw do
  resources :users do
    collection do
      post 'login'
      delete 'logout'
    end
  end

  resources :students
  resources :employees
  root to: 'students#index'
end
