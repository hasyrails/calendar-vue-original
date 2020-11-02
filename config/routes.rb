Rails.application.routes.draw do
  devise_for :admins
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: 'home#index'
  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }
  namespace :api, { format: "json" } do
    scope :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/v1/auth/registrations',
        sessions: 'api/v1/devise_token_auth/sessions'
      }
    end
  end
  namespace :api, { format: "json" } do
    resources :schedules
    patch '/schedules/:id/done', to: 'schedules#done'
    resources :lists
    resources :cards
    patch '/cards/:id/deadlined', to: 'cards#deadlined', as: 'deadlined'
    get '/whoami', to: 'sessions#whoami'
    devise_scope :user do
      post 'users/guest_sign_in', to: 'users#new_guest'
      post 'users/guest_logout', to: 'users#guest_logout'
    end
  end
  get '*path', to: 'home#index'
end
