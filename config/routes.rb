Rails.application.routes.draw do

  root 'welcome#index'
  get 'welcome/hands'=> 'welcome#hands'
  resources :users
  resources :hands
  resource :session

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
