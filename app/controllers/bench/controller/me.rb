module Bench
  module Controller::Me
    extend ActiveSupport::Concern

    included do
      layout -> { turbo_frame_request? ? false : 'me' }
    end

  end
end
