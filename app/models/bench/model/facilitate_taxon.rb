module Bench
  module Model::FacilitateTaxon
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :color, :string
      attribute :description, :string
      attribute :position, :integer
      attribute :facilitates_count, :integer, default: 0
      attribute :indicators_count, :integer, default: 0

      belongs_to :organ, class_name: 'Org::Organ', optional: true

      belongs_to :taxon, optional: true

      has_many :facilitates, dependent: :nullify
      has_many :indicators, dependent: :nullify

      validates :name, presence: true

      default_scope -> { order(position: :asc, id: :asc) }

      acts_as_list
    end

  end
end
