class FacilitateTaxon < ApplicationRecord
  include RailsTaxon::Node
  include RailsBench::FacilitateTaxon
end unless defined? FacilitateTaxon
