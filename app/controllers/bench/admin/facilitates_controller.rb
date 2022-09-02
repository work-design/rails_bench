module Bench
  class Admin::FacilitatesController < Admin::BaseController
    before_action :set_facilitate_taxons, only: [:index, :new, :edit]
    before_action :set_facilitate, only: [
      :show, :edit, :update, :destroy, :actions,
      :wallet, :update_wallet, :card, :update_card
    ]

    def index
      q_params = {}
      q_params.merge! default_params
      q_params.merge! params.permit(:facilitate_taxon_id)

      @facilitates = Facilitate.includes(:facilitate_taxon).default_where(q_params).page(params[:page])
    end

    def wallet
      @wallet_templates = Trade::WalletTemplate.default_where(default_params)
    end

    def update_wallet
      @facilitate.wallet_price = wallet_price_params
      @facilitate.save
    end

    def card
      @card_templates = Trade::CardTemplate.default_where(default_params)
    end

    def update_card
      @facilitate.card_price = card_price_params
      @facilitate.save
    end

    private
    def set_facilitate_taxons
      @facilitate_taxons = FacilitateTaxon.all
    end

    def set_facilitate
      @facilitate = Facilitate.find(params[:id])
    end

    def facilitate_params
      params.fetch(:facilitate, {}).permit(
        :name,
        :description,
        :price,
        :logo,
        :facilitate_taxon_id
      )
    end

    def wallet_price_params
      r = {}

      params.fetch(:service, {}).fetch(:wallet_price, {}).each do |_, v|
        r.merge! v[:code] => v[:price]
      end

      r
    end

    def card_price_params
      r = {}

      params.dig(:service, :card_price).each do |_, v|
        r.merge! v[:code] => v[:price]
      end

      r
    end

  end
end
