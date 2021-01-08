class RoutesReloader
  SKIPPED_PATHS = ['/api/', '/admin/'].freeze

  def initialize(app)
    @app = app
  end

  def call(env)
    if reload_required?(env)
      timestamp = Rails.cache.read(:routes_changed_timestamp)

      if Thread.current[:routes_changed_timestamp] != timestamp
        Frontend::Application.reload_routes!

        Thread.current[:routes_changed_timestamp] = timestamp
      end
    end

    @app.call(env)
  end

  private

  def reload_required?(env)
    SKIPPED_PATHS.none? { |word| env['PATH_INFO'].include?(word) }
  end
end
