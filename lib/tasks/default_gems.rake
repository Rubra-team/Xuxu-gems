namespace :default_gems do
  desc "install default gems"
  task :install do
    XuxuGems::Config.advanced_gems
  end
end
