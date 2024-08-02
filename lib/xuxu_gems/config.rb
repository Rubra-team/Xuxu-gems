module XuxuGems
  class Config
    def self.setup
      add_default_gems
      run_default_commands
      ask_for_optional_gems
    end

    def self.add_default_gems
      add_gem_to_gemfile('annotate')
      add_gem_to_gemfile('rubocop-rails', require: false)
      system("bundle install")
    end

    def self.run_default_commands
      system("rails g annotate:install")
      puts "Annotate instalado."

      system("rubocop --auto-gen-config")
      puts "Rubocop configurado."
    end

    def self.ask_for_optional_gems
      optional_gems = {
        'devise' => 'Devise',
        'devise-i18n' => 'Devise I18n',
        'pundit' => 'Pundit',
        'rolify' => 'Rolify',
        'active_storage_validations' => 'Active Storage Validations',
        'acts_as_list' => 'Acts as List'
      }

      optional_gems.each do |gem_name, gem_description|
        print "Deseja adicionar #{gem_description} ao projeto? [s/N]: "
        answer = gets.chomp.downcase
        if answer == 's'
          add_gem_to_gemfile(gem_name)
        end
      end
      system("bundle install")
    end

    def self.add_gem_to_gemfile(gem_name, options = {})
      gemfile_content = File.read('Gemfile')
      unless gemfile_content.include?(gem_name)
        gem_line = "gem '#{gem_name}'"
        gem_line += ", require: #{options[:require]}" if options[:require]
        File.open('Gemfile', 'a') do |file|
          file.puts gem_line
        end
        puts "#{gem_name} adicionado ao Gemfile."
      end
    end
  end
end
