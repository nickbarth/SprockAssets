# SprockAssets
[![Build Status](https://secure.travis-ci.org/nickbarth/SprockAssets.png?branch=master)](https://travis-ci.org/nickbarth/SprockAssets)
[![Dependency Status](https://gemnasium.com/nickbarth/SprockAssets.png)](https://gemnasium.com/nickbarth/SprockAssets)

SprockAssets is a Rack middleware that makes compiling your assets easy and fast.

## Usage

Here is how to use it.

### Add it to your Gemfile

    gem 'sprock-assets', require: 'sprock_assets'

### Rack apps

Add a use to your `config.ru`

    use SprockAssets

### Sinatra

You can use assets just like in Rails.

    require 'sinatra/base'
    require 'sprock_assets'

    class MyApp < Sinatra::Base
      use SprockAssets
    end

### Create and update the source files

<table>
  <tr>
    <th>Source Path</th>
    <th>Compiled Path</th>
  </tr>
  <tr>
    <td>app/assets/stylesheets/application.css</td>
    <td>public/assets/stylesheets/application.css</td>
  </tr>
  <tr>
    <td>app/assets/javascripts/application.js</td>
    <td>public/assets/javascripts/application.js</td>
  </tr>
</table>

### Serve compiled assets

    ruby config.ru
    curl http://localhost/assets/stylesheets/application.css
    curl http://localhost/assets/javascripts/application.js

Your compiled assets will now be served at their corresponding URIs.  When your
application is run in production your assets will automatically be compiled and
saved to disk.

### Notes

Make sure you require the compressors if you use SprockAssets in production.

    gem 'yui-compressor', require: 'yui/compressor'
    gem 'uglifier', require: 'uglifier'

### License
WTFPL &copy; 2012 Nick Barth
