# frozen_string_literal: true

Rails.application.routes.draw do
  resources :tests
  resources :transactions
  resources :cars do
    resources :drivers, controller: "cars/drivers"
  end
end
