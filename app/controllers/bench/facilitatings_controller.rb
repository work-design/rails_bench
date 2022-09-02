module Bench
  class FacilitatingsController < BaseController
    before_action :require_login
    before_action :set_facilitating, only: [:qrcode]

    def qrcode
      if current_user.organ_ids.include?(@facilitating.facilitate.organ_id)
        redirect_to({ controller: 'serve/me/facilitatings', action: 'qrcode', id: params[:id], host: @facilitating.facilitate.organ.host }, allow_other_host: true)
      end
    end

    private
    def set_facilitating
      @facilitating = Facilitating.find params[:id]
    end

  end
end
