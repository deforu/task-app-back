Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:show, :update] do
        collection do
          get 'me', to: 'users#me'
          put :avatar, to: 'users#update_avatar'
        end
        member do
          # 特定ユーザーの詳細と画像アップロード用エンドポイント
          get :avatar, to: 'users#show'
          put :avatar, to: 'users#update'
        end
      end

      resources :todos do
        collection do
          get 'important', to: 'todos#important'
          get 'today', to: 'todos#today'
          get 'completed', to: 'todos#completed'
        end
      end

      # フォルダのCRUD操作用のルートを追加
      resources :folders do
        resources :todos, only: [:index, :create] # フォルダ内のタスク操作用
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
