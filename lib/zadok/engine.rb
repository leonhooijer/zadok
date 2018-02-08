# frozen_string_literal: true

Gem.loaded_specs["zadok"].dependencies.each do |d|
  next if d.name.in?(%w[bundler-audit])
  require d.name
end

module Zadok
  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  class Configuration
    attr_accessor :parent_controller

    def initialize
      @parent_controller = ::ApplicationController
    end
  end

  class Engine < ::Rails::Engine
    isolate_namespace Zadok
  end
end
