module Bench
  class FacilitateTaxon < ApplicationRecord
    include Com::Ext::Taxon
    include RailsBench::FacilitateTaxon
  end
end
