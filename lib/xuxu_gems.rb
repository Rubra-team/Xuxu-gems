# frozen_string_literal: true

require_relative "xuxu_gems/version"
require_relative "xuxu_gems/config"

module XuxuGems
  class Error < StandardError; end
  def self.setup
    Config.setup
  end
end
