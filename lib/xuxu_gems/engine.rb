# lib/xuxu_gems/engine.rb
module XuxuGems
  class Engine < ::Rails::Engine
    isolate_namespace XuxuGems

    initializer "xuxu_gems.add_middleware" do |app|
      app.routes.append do
        scope module: "xuxu_gems" do
          get "xuxu/gems/installed", to: "gems#installed"
        end
      end
    end
  end
end
