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
      compile:          false
    }.merge(settings)


    javascript_file = "#{Dir.pwd}/#{@settings[:javascripts_path]}/application.js"
    unless File.exists? javascript_file
      raise "Javascript application file (#{javascript_file}) was not found"
    end

    stylesheet_file = "#{Dir.pwd}/#{@settings[:stylesheets_path]}/application.css"
    unless File.exists? stylesheet_file
      raise "Stylesheet application file (#{stylesheet_file}) was not found"
    end

    @assets = Sprockets::Environment.new(Dir.pwd) do |assets|
      assets.logger = Logger.new(STDOUT)
      assets.append_path @settings[:assets_path]
      assets.append_path @settings[:javascripts_path]
      assets.append_path @settings[:stylesheets_path]
      if compile
        assets.js_compressor = Uglifier.new({ mangle: true })
        assets.css_compressor = YUI::CssCompressor.new
        assets.cache = Sprockets::Cache::FileStore.new("/public")
      end
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
