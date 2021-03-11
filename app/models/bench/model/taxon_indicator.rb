module Bench
  module Model::TaxonIndicator
    extend ActiveSupport::Concern

    included do
      belongs_to :taxon
      belongs_to :facilitate_taxon
      belongs_to :indicator
    end

  end
end
