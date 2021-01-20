module Bench
  class FacilitateTaxon < ApplicationRecord
    include Com::Ext::Taxon
    include Model::FacilitateTaxon
  end
end
