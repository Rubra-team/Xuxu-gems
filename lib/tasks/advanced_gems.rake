# frozen_string_literal: true

namespace :advanced_gems do
  desc "install advanced gems"
  task :install do
    XuxuGems::Config.advanced_gems
  end
end
