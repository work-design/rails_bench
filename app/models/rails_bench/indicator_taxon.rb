module RailsBench::IndicatorTaxon
  extend ActiveSupport::Concern

  included do
    attribute :name, :string
    attribute :color, :string
    attribute :description, :string, limit: 4096
    attribute :indicators_count, :integer

    belongs_to :organ, optional: true
    has_many :indicators

    validates :name, presence: true
  end

end
