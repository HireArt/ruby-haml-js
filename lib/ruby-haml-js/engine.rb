module RubyHamlJs
  class Engine < Rails::Engine
    initializer "ruby-hamljs.configure_rails_initialization", :after => 'sprockets.environment', :group => :all do |app|
      next unless app.assets

      require 'ruby-haml-js/template'

      app.assets.register_engine '.hamljs', ::RubyHamlJs::Template, { mime_type: 'text/hamljs', silence_deprecation: true }
    end
  end
end
