module Bench
  module Model::Indicator
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :description, :string
      attribute :unit, :string
      attribute :reference_min, :decimal
      attribute :reference_max, :decimal
      attribute :target_source, :string

      has_many :taxon_indicators, dependent: :destroy
      has_many :project_indicators, dependent: :destroy

      validates :name, presence: true
    end

  end
end
