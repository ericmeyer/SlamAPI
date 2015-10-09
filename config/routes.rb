Rails.application.routes.draw do

  root 'welcome#index'

  post 'login', to: 'sessions#create'

  get 'matches', to: 'matches#index'
  post 'matches', to: 'matches#create'
  delete 'matches', to: 'matches#destroy'

end
