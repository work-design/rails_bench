require 'active_support/configurable'

module RailsBench #:nodoc:
  include ActiveSupport::Configurable

  configure do |config|
    config.app_controller = 'ApplicationController'
    config.my_controller = 'MyController'
    config.board_controller = 'BoardController'
    config.admin_controller = 'AdminController'
  end

end


