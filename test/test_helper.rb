# wycats says...
require 'rubygems'
require 'bundler'
Bundler.setup

require 'shoulda'

ENV['RAILS_ENV'] = 'test'
require "dummy/config/environment"
require "rails/test_help" # sets up ActionController::TestCase's @routes

require 'apotomo'

Cell::Base.append_view_path File.expand_path(File.dirname(__FILE__) + "/fixtures")

# Load test support files.
#require File.join(File.dirname(__FILE__), "support/test_case_methods")


class ApotomoController < ActionController::Base
  include Apotomo::Rails::ControllerMethods
  include Rails.application.routes.url_helpers
end

module Farm
  class BarnController < ApotomoController
  end
end

class MouseWidget < Apotomo::Widget
end


class MouseWidget < Apotomo::Widget
  def squeak
  end
  def eating
    render
  end
end

# Enable dynamic states so we can do Cell.class_eval { def ... } at runtime.
Apotomo::Widget.class_eval do
  def action_method?(*); true; end
end
