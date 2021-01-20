module Bench
  class Project < ApplicationRecord
    include Model::Project
    include Com::Ext::Extra
    include RailsFinanceExt::Financial if defined? RailsFinance
  end
end
