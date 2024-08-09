require "rails"

module XuxuGems
  class Railtie < Rails::Railtie
    railtie_name :xuxu_gems

    rake_tasks do
      load "tasks/default_gems.rake"
      load "tasks/advanced_gems.rake"
    end
  end
end
