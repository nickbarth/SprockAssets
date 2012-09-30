require 'sprockets'
require 'sprock_assets/version'

class SprockAssets
  # Public: Gets/Sets the Rack application instance.
  attr_accessor :app
  # Public: Gets/Sets the middleware settings.
  attr_accessor :settings
  # Public: Gets/Sets the Sprockets Enviroment.
  attr_accessor :assets

  # Public: Initialize SprockAssets a middleware.
  #
  # app - The current Rack app.
  # settings - A hash of the asset path settings.
  def initialize(app, settings={})
    @app = app
    @settings = {
      assets_path:      'app',
      javascripts_path: 'app/assets/stylesheets',
      stylesheets_path: 'app/assets/javascripts',
    }.merge(settings)

    @assets = Sprockets::Environment.new(Dir.pwd) do |assets|
      assets.logger = Logger.new(STDOUT)
      assets.append_path @settings[:assets_path]
      assets.append_path @settings[:javascripts_path]
      assets.append_path @settings[:stylesheets_path]
    end
  end

  # Public: A rack middleware call method routing URLs under /assets/ to the SprockAssets middleware.
  def call(env)
    if env['PATH_INFO'][/^\/assets/].nil?
      @app.call env
    else
      @assets.call env
    end
  end
end
