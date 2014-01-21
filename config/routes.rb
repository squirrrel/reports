Reports::Application.routes.draw do
  namespace :admin do
    resources :templates
  end
end
