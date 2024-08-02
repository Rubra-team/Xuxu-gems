require "xuxu_gems/version"
require "xuxu_gems/config"
require "xuxu_gems/railtie" if defined?(Rails)

module XuxuGems
  class Error < StandardError; end

  def self.setup
    Config.setup
  end
end
