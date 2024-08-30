Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :todos do
        collection do
          get 'important', to: 'todos#important'
          get 'today', to: 'todos#today'
          get 'completed', to: 'todos#completed'
        end
      end
    end 
  end 
end