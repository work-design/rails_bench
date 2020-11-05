class ProjectTaxon < ApplicationRecord
  include RailsBench::ProjectTaxon
  include RailsBenchExt::OtherTasking
  include RailsComExt::Parameter
  include RailsFinanceExt::Financial if defined? RailsFinanceExt
end unless defined? ProjectTaxon
