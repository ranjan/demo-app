Rails.application.routes.draw do
  resources :users

  root 'pages#index'

end
