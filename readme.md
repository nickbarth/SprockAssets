# SprockAssets
[![Build Status](https://secure.travis-ci.org/nickbarth/SprockAssets.png?branch=master)](https://travis-ci.org/nickbarth/SprockAssets)
[![Dependency Status](https://gemnasium.com/nickbarth/SprockAssets.png)](https://gemnasium.com/nickbarth/SprockAssets)

SprockAssets is a Rack middleware that makes compiling your assets on the fly with Sprockets easy and fast.

## Usage

Here is how to use it.

### Add it to your Gemfile

    gem 'sprock-assets', require: 'sprock_assets'

### Vanilla Rack apps

Add a use to your `config.ru`

    use SprockAssets

### Sinatra

If you are using Sinatra, you can use the flash hash just like in Rails:

    require 'sinatra/base'
    require 'sprock_assets'

    class MyApp < Sinatra::Base
      use SprockAssets
    end

### Create and update the source files

<table>
  <tr>
    <th>Default source file</th>
  </tr>
  <tr>
    <td>app/assets/stylesheets/application.css</td>
  </tr>
  <tr>
    <td>app/assets/javascripts/application.js</td>
  </tr>
</table>

### Serve compiled assets

    ruby config.ru
    curl http://localhost/assets/stylesheets/application.css
    curl http://localhost/assets/javascripts/application.js

Your compiled assets will now be served at their corresponding URIs.

### License
WTFPL &copy; 2012 Nick Barth
