Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
  mount_devise_token_auth_for 'User', at: 'api/v1/auth', controllers: {
    registrations: 'api/v1/users/registrations',
    sessions: 'api/v1/users/sessions'
  }
  namespace :api do
    namespace :v1, defaults: { format: :json } do
      devise_scope :user do
        resources :topics, only: :index
      end
    end
  end
end
