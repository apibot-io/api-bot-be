class Apibot::Router
  METHODS = [:get, :post, :put, :patch, :delete, :options, :head].freeze

  class << self
    def load_mock_routes!
      Mock.active.each do |mock|
        define_route(mock)
      end
    end

    def reload_routers
      ApiBotBackend::Application.routes_reloader.reload!
    end

    protected

    def define_route(mock)
      ApiBotBackend::Application.routes.draw do
        scope module: 'api/v0' do
          send(:match, mock.route_path, to: 'mocks#serve_mock', defaults: { mock_id: mock.id }, via: mock.request_method)
        end
      end
    end
  end
end
