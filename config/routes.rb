Rails.application.routes.draw do
  root 'home#index'

  get 'favourite_languages/:username' => 'favourite_languages#show'
end
