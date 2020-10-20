class ProjectTaxon < ApplicationRecord
  include RailsBench::ProjectTaxon
  include RailsBenchExt::OtherTasking
  include RailsComExt::Extra
  include RailsFinanceExt::Financial if defined? RailsFinance
end unless defined? ProjectTaxon
