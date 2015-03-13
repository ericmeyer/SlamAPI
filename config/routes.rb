Rails.application.routes.draw do

  root 'welcome#index'
  get 'matches', to: 'matches#index'
  get 'matches', to: 'matches#pending_matches'
  post 'matches', to: 'matches#create'
end
