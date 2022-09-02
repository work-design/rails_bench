module Bench
  class Taxon < ApplicationRecord
    include Model::Taxon
    include Com::Ext::Parameter
    include Finance::Ext::Financial if defined? RailsFinance
  end
end
