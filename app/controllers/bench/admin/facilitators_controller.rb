module Bench
  class Admin::FacilitatorsController < Admin::BaseController
    before_action :set_facilitate
    before_action :set_new_facilitator, only: [:new, :create]
    before_action :set_members, only: [:new, :create, :edit, :update]

    def index
      @facilitators = @facilitate.facilitators.page(params[:page])
    end

    private
    def set_facilitate
      @facilitate = Facilitate.find params[:facilitate_id]
    end

    def set_new_facilitator
      @facilitator = @facilitate.facilitators.build(facilitator_params)
    end

    def set_members
      @members = ::Org::Member.default_where(default_params)
    end

    def facilitator_params
      params.fetch(:facilitator, {}).permit(
        :name,
        :member_id,
        :avatar,
        :description
      )
    end

  end
end
