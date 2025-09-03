Rails.application.routes.draw do
  devise_for :users

  get "/up", to: proc { [200, {"Content-Type"=>"text/plain"}, ["OK"]] }

  resources :docs, only: [:index, :new, :create, :show]

  resources :assets, path: "network_assets" do
    resources :incidents, shallow: true do
      resources :incident_events, shallow: true
    end
    resources :work_orders, shallow: true
  end

  get "map", to: "map#show", as: :map

  resources :incidents,  only: [:index]
  resources :work_orders, only: [:index]

  root "home#index"
end

