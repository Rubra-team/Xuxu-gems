module Helpers
  # Helper para adicionar gems ao Gemfile
  module AddGemToGemfile
    def add_gem_to_gemfile(gem_name, options = {})
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