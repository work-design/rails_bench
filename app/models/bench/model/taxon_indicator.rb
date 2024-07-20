module Bench
  module Model::TaxonIndicator
    extend ActiveSupport::Concern

    included do
      attribute :weight, :integer

      belongs_to :taxon
      belongs_to :indicator
    end

  end
end
