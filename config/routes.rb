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
      
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/v1/auth/registrations'
      }

      namespace :auth do
        resources :sessions, only: %i[index]
      end
    end 
  end 
end