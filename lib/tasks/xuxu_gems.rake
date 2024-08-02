namespace :xuxu_gems do
  desc "Generate default gems"
  task :generate do
    XuxuGems::Config.setup
  end
end
