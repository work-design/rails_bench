module RailsBench::IndicatorTaxon
  extend ActiveSupport::Concern

  included do
    attribute :name, :string
    attribute :color, :string
    attribute :description, :string
    attribute :indicators_count, :integer

    belongs_to :organ, optional: true
    has_many :indicators, dependent: :nullify

    validates :name, presence: true
  end

end
