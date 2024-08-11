require "rails"

module XuxuGems
  class Railtie < Rails::Railtie
    railtie_name :xuxu_gems

    rake_tasks do
      load "tasks/gems_generator.rake"
    end
  end
end
