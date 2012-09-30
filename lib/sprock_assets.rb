require 'fileutils'
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
      javascripts_path: 'app/assets/javascripts',
      stylesheets_path: 'app/assets/stylesheets',
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

  # Public: Generates the configured file structure for an applications assets.
  def generate_assets
    FileUtils.mkdir_p "#{@settings[:javascripts_path]}/coffee"
    FileUtils.mkdir_p "#{@settings[:stylesheets_path]}/scss"
    File.open("#{@settings[:javascripts_path]}/application.js", 'w') do |application_js|
      application_js << (<<-EOS).gsub('      ', '')
      //= require_tree ./coffee
      EOS
    end
    File.open("#{@settings[:stylesheets_path]}/application.css", 'w') do |application_css|
      application_css << (<<-EOS).gsub('      ', '')
      /*
       *= require_tree ./scss
       */
      EOS
    end
  end
end
