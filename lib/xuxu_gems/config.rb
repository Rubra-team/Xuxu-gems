module XuxuGems
  class Config
    def self.setup
      add_default_gems
      run_default_commands
      ask_for_optional_gems
    end

    def self.add_default_gems
      add_gem_to_gemfile('annotate', git: 'https://github.com/ctran/annotate_models.git')
      add_gem_to_gemfile('rubocop-rails', require: false)
      system("bundle install")
    end

    def self.run_default_commands
      system("rails g annotate:install")
      puts "Gem [Annotate] are installed and configured."

      system("rubocop --auto-gen-config")
      puts "Gem [Rubocop] are installed and configured."
    end

    def self.ask_for_optional_gems
      optional_gems = {
        'devise' => { name: 'devise', link: 'https://github.com/heartcombo/devise' },
        'devise-i18n' => { name: 'devise-i18n', link: 'https://github.com/tigrish/devise-i18n' },
        'pundit' => { name: 'pundit', link: 'https://github.com/varvet/pundit' },
        'rolify' => { name: 'rolify', link: 'https://github.com/RolifyCommunity/rolify' },
        'active_storage_validations' => { name: 'active_storage_validations', link: 'https://github.com/igorkasyanchuk/active_storage_validations' },
        'acts_as_list' => { name: 'acts_as_list', link: 'https://github.com/brendon/acts_as_list' }
      }

      optional_gems.each do |gem_name, gem_github|
        print "Would you like to install #{gem_name} gem? (Y/n): "
        answer = gets.chomp.upcase
        if answer == 'Y'
          add_gem_to_gemfile(gem_name, git: gem_github[:link])
        end
      end
      system("bundle install")
    end

    def self.add_gem_to_gemfile(gem_name, options = {})
      gemfile_content = File.read('Gemfile')
      unless gemfile_content.include?(gem_name)
        gem_line = "gem '#{gem_name}'"
        gem_line += ", require: #{options[:require]}" if options[:require]
        gem_line += ", git: '#{options[:git]}'" if options[:git]
        File.open('Gemfile', 'a') do |file|
          file.puts gem_line
        end
        puts "[#{gem_name}] added to Gemfile."
      end
    end
  end
end
