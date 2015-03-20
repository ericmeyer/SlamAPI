Rails.application.routes.draw do

  root 'welcome#index'
  get 'matches', to: 'matches#index'
  post 'matches', to: 'matches#create'
  delete 'matches', to: 'matches#destroy'
end
