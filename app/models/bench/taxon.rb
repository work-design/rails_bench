module Bench
  class Taxon < ApplicationRecord
    self.table_name = 'project_taxons'

    include Model::Taxon
    include Com::Ext::Parameter
    include Finance::Ext::Financial if defined? RailsFinance
  end
end
