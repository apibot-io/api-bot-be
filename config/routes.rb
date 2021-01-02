require 'apibot/router'

Rails.application.routes.draw do
  Apibot::Router.load_mock_routes!
end
