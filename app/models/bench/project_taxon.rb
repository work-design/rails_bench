module Bench
  class ProjectTaxon < ApplicationRecord
    include RailsBench::ProjectTaxon
    include RailsComExt::Parameter
    include RailsFinanceExt::Financial if defined? RailsFinanceExt
  end
end
