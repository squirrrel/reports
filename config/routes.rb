Reports::Application.routes.draw do
  devise_for :users

	root to: 'reports#index'

  namespace :admin do
    resources :templates
  end
  resources :reports
end
