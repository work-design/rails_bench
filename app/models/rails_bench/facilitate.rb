module RailsBench::Facilitate
  extend ActiveSupport::Concern

  included do
    attribute :quantity, :integer, default: 1
    attribute :unified_quantity, :integer, default: 1
    attribute :unit, :string, default: '个'
    attribute :description, :string
    attribute :qr_prefix, :string
    attribute :published, :boolean, default: true

    belongs_to :organ, optional: true
    belongs_to :facilitate_taxon, autosave: true, counter_cache: true

    has_one :facilitate_provider, -> { where(selected: true) }
    has_one :provider, through: :facilitate_provider
    has_many :facilitate_providers, dependent: :destroy
    has_many :providers, through: :facilitate_providers

    has_one_attached :logo
  end

end
