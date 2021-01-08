require 'apibot/router'

Rails.application.routes.draw do
  namespace 'api', format: 'json' do
    scope module: 'v0' do
      resources :resources, only: [:index, :show, :create, :update, :delete]
      resources :mocks, only: [:create]
    end
  end

  Apibot::Router.load_mock_routes!

  match '*unmatched', to: 'application#route_not_found', via: :all
end
