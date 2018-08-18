Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homes#homepage'
  get 'profile', to: 'users#show'
  get 'edit_profile', to: 'users#edit'

  get 'hunt', to: 'hunts#index'
  get 'show_hunt', to: 'hunts#show'
  get 'join_hunt', to: 'hunts#join'
  get 'next_hunt', to: 'hunts#next'
  get 'previous_hunt', to: 'hunts#previous'
  get 'find_hunts', to: 'hunts#find'
  get 'preset_query_hunt',  to: 'hunts#preset_query'

  post 'hunt', to: 'hunts#create'
  patch 'sid_update_hunt', to: 'hunts#sid_update'
  patch 'leave_hunt',to: 'hunts#leave'

  delete 'delete_hunt', to: 'hunts#destroy'
end
