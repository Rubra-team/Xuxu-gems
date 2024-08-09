require "xuxu_gems/version"
require "xuxu_gems/config"
require "xuxu_gems/railtie" if defined?(Rails)

module XuxuGems
  class Error < StandardError; end

  def self.default_gems
    Config.default_gems
  end

  def self.advanced_gems
    Config.advanced_gems
  end
end
