class Bench::My::BaseController < MyController
  #before_action :require_worker
  helper_method :current_worker
  layout 'application'

  def current_worker
    @current_worker ||= current_user.present_worker
  end



  def rails_role_user
    current_worker
  end

end
