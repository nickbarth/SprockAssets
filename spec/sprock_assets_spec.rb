require 'spec_helper'

describe SprockAssets do
  Uglifier = Module.new
  YUI = Module.new
  YUI::CssCompressor = Module.new

  before(:each) do
    File.stub(:exists? => true)
    Uglifier.stub(:new)
    YUI::CssCompressor.stub(:new)
  end

  context 'on Rack initialize' do
    let(:env) { Sprockets::Environment.any_instance }

    it 'takes in custom paths' do
      ENV['RACK_ENV'] = 'test'
      env.should_receive(:append_path).with('ASSETS_PATH')
      env.should_receive(:append_path).with('ASSETS_PATH/JAVASCRIPTS_PATH')
      env.should_receive(:append_path).with('ASSETS_PATH/STYLESHEETS_PATH')
      SprockAssets.new nil, assets_path:      'ASSETS_PATH',
                            javascripts_path: 'JAVASCRIPTS_PATH',
                            stylesheets_path: 'STYLESHEETS_PATH'
    end

    it 'sets compressors on compile flag' do
      ENV['RACK_ENV'] = 'production'
      env.stub(:find_asset) { double(:asset, write_to: '') }
      env.should_receive(:js_compressor=)
      env.should_receive(:css_compressor=)
      SprockAssets.new nil
    end
  end

  context 'on Rack request' do
    before(:each) do
      ENV['RACK_ENV'] = 'test'
    end

    it 'should invoke Sprocket on URIs under /assets/' do
      rack_app = SprockAssets.new nil
      rack_app.assets.should_receive(:call)
      rack_app.call 'PATH_INFO' => '/assets/'
    end

    it 'should not invoke Sprocket for other URIs' do
      rack_app = SprockAssets.new double
      rack_app.app.should_receive(:call)
      rack_app.call 'PATH_INFO' => '/other/'
    end
  end
end
