module RubyHamlJs
  class Engine < Rails::Engine
    initializer "ruby-hamljs.configure_rails_initialization", :after => 'sprockets.environment', :group => :all do |app|
      next unless app.assets

      require 'tilt_processor'
      require 'ruby-haml-js/template'

      app.assets.register_mime_type 'application/javascript', extensions: ['.hamljs', '.jst.hamljs'], charset: :default
      app.assets.register_preprocessor 'application/javascript', TiltProcessor.new(::RubyHamlJs::Template)
    end
  end
end
