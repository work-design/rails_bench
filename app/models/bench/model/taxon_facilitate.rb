module Bench
  module Model::TaxonFacilitate
    extend ActiveSupport::Concern

    included do


      belongs_to :taxon
      belongs_to :facilitate
    end

  end
end
