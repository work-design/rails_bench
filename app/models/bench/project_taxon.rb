module Bench
  class ProjectTaxon < ApplicationRecord
    include Model::ProjectTaxon
    include Com::Ext::Parameter
    include Finance::Ext::Financial if defined? RailsFinance
  end
end
