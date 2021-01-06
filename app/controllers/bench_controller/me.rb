module BenchController::Me
  extend ActiveSupport::Concern

  included do
    layout 'me'
  end

  class_methods do
    def local_prefixes
      [controller_path, 'bench/me/base', 'me']
    end
  end

end unless defined? BenchController::Me
