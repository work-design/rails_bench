module Bench
  class ProjectTaxon < ApplicationRecord
    include Model::ProjectTaxon
    include Com::Ext::Parameter
    include RailsFinanceExt::Financial if defined? RailsFinanceExt
  end
end
