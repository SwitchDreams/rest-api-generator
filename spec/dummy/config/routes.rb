# frozen_string_literal: true

Rails.application.routes.draw do
  resources :transactions
  resources :cars
end
