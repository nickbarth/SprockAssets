require 'sprockets'
require 'sprock_assets/version'

class SprockAssets
  attr_accessor :app, :settings, :assets

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

  def call(env)
    if env['PATH_INFO'][/^\/assets/].nil?
      @app.call env
    else
      @assets.call env
    end
  end
end
