Rails.application.routes.draw do
  devise_for :users
  resources :lists do
    resources :movies do
      post 'complete' => 'movies#change_status'
    end
  end

  get '/completed_movies' => 'movies#completed_movies'

  root 'home#index'
end
