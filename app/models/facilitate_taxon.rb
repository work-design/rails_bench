class FacilitateTaxon < ApplicationRecord
  include RailsCom::Taxon
  include RailsBench::FacilitateTaxon
end unless defined? FacilitateTaxon
