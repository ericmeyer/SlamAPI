Rails.application.routes.draw do

  root 'welcome#index'
  get 'matches', to: 'matches#index'
end
