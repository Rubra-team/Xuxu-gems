# frozen_string_literal: true

# gems generator

namespace :gems do
  desc "install default gems"
  task :default do
    XuxuGems::Config.default_gems
  end

  desc "install advanced gems"
  task :advanced do
    XuxuGems::Config.advanced_gems
  end
end
