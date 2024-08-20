# lib/xuxu_gems/controllers/gems_controller.rb
module XuxuGems
  class GemsController < ApplicationController
    def installed
      @gems = parse_gemfile
    end

    private

    def parse_gemfile
      gemfile_path = Rails.root.join("Gemfile")
      gemfile_content = File.read(gemfile_path)
      gemfile_content.scan(/^gem\s+'(.*?)'/).flatten
    end
  end
end
