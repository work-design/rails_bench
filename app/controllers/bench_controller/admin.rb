module BenchController::Admin
  extend ActiveSupport::Concern

  included do
  end

  class_methods do
    def local_prefixes
      [controller_path, 'bench/admin/base']
    end
  end

end unless defined? BenchController::Admin
