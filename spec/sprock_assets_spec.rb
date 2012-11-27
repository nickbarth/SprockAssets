require 'spec_helper'

describe SprockAssets do
  context 'on Rack initialize' do
    it 'takes in custom paths' do
      env = Sprockets::Environment.any_instance
      env.should_receive(:append_path).with('ASSETS_PATH')
      env.should_receive(:append_path).with('JAVASCRIPTS_PATH')
      env.should_receive(:append_path).with('STYLESHEETS_PATH')
      SprockAssets.new nil, assets_path:      'ASSETS_PATH',
                            javascripts_path: 'JAVASCRIPTS_PATH',
                            stylesheets_path: 'STYLESHEETS_PATH'
    end
  end

  context 'on Rack request' do
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
