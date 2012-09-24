require 'sprock_assets/version'
require 'sprockets'

class SprockAssets
  def initialize app
    puts ">> Asset compiler enabled"
    @app = app
    @env = Sprockets::Environment.new(Dir.pwd) do |env|
      env.logger = Logger.new(STDOUT)
    end
    @env.append_path 'app'
    @env.append_path 'app/assets/stylesheets'
    @env.append_path 'app/assets/javascripts'
  end

  def call env
    if env['PATH_INFO'][/^\/assets/].present?
      @env.call env
    else
      @app.call env
    end
  end
end
