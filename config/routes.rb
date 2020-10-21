Rails.application.routes.draw do
  root to: 'home#index'
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
    get '/whoami', to: 'sessions#whoami'
  end
  get '*path', to: 'home#index'
end
