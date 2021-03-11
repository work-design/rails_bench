module Bench
  class TaxonIndicator < ApplicationRecord
    self.table_name = 'project_taxon_indicators'
    include Model::TaxonIndicator
  end
end
