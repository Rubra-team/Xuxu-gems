namespace :xuxu_gems do
  desc "Configura as gems e executa comandos no projeto Rails"
  task :generate do
    XuxuGems::Config.setup
  end
end
