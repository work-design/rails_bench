module RailsBenchController::Me
  extend ActiveSupport::Concern

  included do
    layout 'me'
  end

end unless defined? RailsBenchController::Me
