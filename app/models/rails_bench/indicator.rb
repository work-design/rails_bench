module RailsBench::Indicator
  extend ActiveSupport::Concern

  included do
    attribute :name, :string
    attribute :description, :string
    attribute :unit, :string
    attribute :reference_min, :decimal
    attribute :reference_max, :decimal
    attribute :targt_source, :string

    belongs_to :organ, optional: true
    belongs_to :indicator_taxon
    has_many :project_indicators, dependent: :destroy

    validates :name, presence: true
  end

end