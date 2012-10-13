# SprockAssets

SprockAssets is a Rack Middleware you can include in your application for compiling your assets on the fly with Sprockets.

## Usage

Here's how to use it.

### Add it to your Gemfile

    gem 'sprock-assets', require: 'sprock_assets'

### Vanilla Rack apps

Add a use to your `config.ru`

    use SprockAssets

### Sinatra

If you're using Sinatra, you can use the flash hash just like in Rails:

    require 'sinatra/base'
    require 'sprock_assets'

    class MyApp < Sinatra::Base
      use SprockAssets
    end

### Generate default assets

Use the built in generator to generate some default assets. 

    bundle exec sprock-assets generate_assets

It will create a directory structure and default assets based on the configured settings.

    tree app/
    app/
    └── assets
        ├── javascripts
        │   ├── application.js
        │   └── coffee
        └── stylesheets
            ├── application.css.scss
            └── scss

### Serve compiled assets

    ruby config.ru
    curl http://localhost/assets/stylesheets/application.css
    curl http://localhost/assets/javascripts/application.js
    
Your compiled assets will now be served at their corresponding URIs.

### License
WTFPL &copy; 2012 Nick Barth
