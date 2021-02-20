module Bench
  class Admin::MilepostsController < Admin::BaseController
    before_action :set_milepost, only: [:show, :edit, :update, :move_higher, :move_lower, :destroy]

    def index
      q_params = {}
      q_params.merge! default_params

      @mileposts = Milepost.default_where(q_params).page(params[:page])
    end

    def new
      @milepost = Milepost.new
    end

    def create
      @milepost = Milepost.new(milepost_params)

      unless @milepost.save
        render :new, locals: { model: @milepost }, status: :unprocessable_entity
      end
    end

    def show
    end

    def edit
    end

    def update
      @milepost.assign_attributes(milepost_params)

      unless @milepost.save
        render :edit, locals: { model: @milepost }, status: :unprocessable_entity
      end
    end

    def move_higher
      @milepost.move_higher
    end

    def move_lower
      @milepost.move_lower
    end

    def destroy
      @milepost.destroy
    end

    private
    def set_milepost
      @milepost = Milepost.find params[:id]
    end

    def milepost_params
      p = params.fetch(:milepost, {}).permit(
        :name
      )
      p.merge! default_form_params
    end

  end
end
