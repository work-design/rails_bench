module Bench
  class TaxonFacilitate < ApplicationRecord
    self.table_name = 'project_taxon_facilitates'
    include Model::TaxonFacilitate
  end
end
