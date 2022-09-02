module Bench
  class My::FacilitatingsController < My::BaseController
    before_action :set_item

    def index
      @facilitatings = @item.facilitatings
    end

    private
    def set_item
      @item = Trade::Item.find params[:item_id]
    end

  end
end
