Rails.application.routes.draw do

  root 'welcome#index'
  get 'welcome/hands'=> 'welcome#hands'
  get 'users/:id/statistics'=> 'users#statistics'

  resources :users
  resources :hands
  resource :session

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
