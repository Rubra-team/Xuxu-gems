module XuxuGems
  require "yaml"
  require_relative "../helpers/add_gem_to_gemfile"

  class Config
    extend Helpers::AddGemToGemfile

    def self.default_gems
      add_default_gems
      run_default_commands
    end

    def self.advanced_gems
      ask_for_optional_gems
    end

    def self.add_default_gems
      puts "Adding default gems to Gemfile..."
      yml_path = File.join(__dir__, "files/default_gems.yml")
      default_gems = YAML.load_file(yml_path)

      default_gems.each_value do |gem_info|
        gem_name = gem_info["name"]
        git_url = gem_info["git_url"]

        if git_url.eql?(true)
          gem_git = gem_info["git"]
          add_gem_to_gemfile(gem_name, git: gem_git)
        else
          add_gem_to_gemfile(gem_name)
        end
      end
    end

    def self.run_default_commands
      system("rails g annotate:install")
      puts "Gem [Annotate] is installed and configured."

      system("rubocop --auto-gen-config")
      puts "Gem [Rubocop] is installed and configured."
    end

    def self.ask_for_optional_gems
      yml_path = File.join(__dir__, "files/advanced_gems.yml")
      advanced_gems = YAML.load_file(yml_path)

      advanced_gems.each_value do |gem_info|
        gem_name = gem_info["name"]
        git_url = gem_info["git_url"]

        print "Would you like to install the #{gem_name} gem? (Y/n): "
        answer = gets.chomp.upcase

        if answer == "Y"
          if git_url.eql?(true)
            gem_git = gem_info["git"]
            add_gem_to_gemfile(gem_name, git: gem_git)
          else
            add_gem_to_gemfile(gem_name)
          end
        end
      end

      system("bundle install")
    end
  end
end