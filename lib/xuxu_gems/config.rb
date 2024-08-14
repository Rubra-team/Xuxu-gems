# frozen_string_literal: true

# config
module XuxuGems
  require "yaml"

  class Config
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

      default_gems.each do |gem_info|
        gem_name = gem_info["name"]
        gem_git = gem_info["git"]


        add_gem_to_gemfile(gem_name, git: gem_git)
      end
    end

    def self.run_default_commands
      system("rails g annotate:install")
      puts "Gem [Annotate] are installed and configured."

      system("rubocop --auto-gen-config")
      puts "Gem [Rubocop] are installed and configured."
    end

    def self.ask_for_optional_gems
      yml_path = File.join(__dir__, "files/advanced_gems.yml")
      advanced_gems = YAML.load_file(yml_path)
      advanced_gems.each_value do |gem_info|
        gem_name = gem_info["name"]
        gem_git = gem_info["git"]

        print "Would you like to install the #{gem_name} gem? (Y/n): "
        answer = gets.chomp.upcase
        add_gem_to_gemfile(gem_name, git: gem_git) if answer == "Y"
      end
      system("bundle install")
    end

    def self.add_gem_to_gemfile(gem_name, options = {})
      gemfile_content = File.read("Gemfile")
      return if gemfile_content.include?(gem_name)

      gem_line = "gem '#{gem_name}'"
      gem_line += ", require: #{options[:require]}" if options[:require]
      gem_line += ", git: '#{options[:git]}'" if options[:git]
      File.open("Gemfile", "a") do |file|
        file.puts gem_line
      end
      puts "[#{gem_name}] added to Gemfile."

    end
  end
end
