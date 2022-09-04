module Bench
  class Me::FacilitatingsController < Me::BaseController
    before_action :set_facilitating, only: [:qrcode, :start, :finish]

    def index
      @facilitatings = current_member.facilitatings.page(params[:page])
    end

    def qrcode

    end

    def start
      @facilitating.member = current_member
      @facilitating.start_at = Time.current
      @facilitating.save
    end

    def finish
      @facilitating.finish_at = Time.current
      @facilitating.save
    end

    private
    def set_facilitating
      @facilitating = Facilitating.find params[:id]
    end

  end
end
