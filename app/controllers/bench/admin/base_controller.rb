class Bench::Admin::BaseController < AdminController

  def rails_role_user
    current_user
  end

end
