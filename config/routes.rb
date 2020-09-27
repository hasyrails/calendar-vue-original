Rails.application.routes.draw do
  root to: 'home#index'
  namespace :api, { format: "json" } do
    resources :schedules
    resources :lists
  end
  get '*path', to: 'home#index'
end
