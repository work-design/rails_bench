module Bench
  class Admin::BaseController < AdminController
    append_view_path RailsBench::Engine.root.join('app/vue')
  end
end
