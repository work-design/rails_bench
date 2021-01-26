module Bench
  class Project < ApplicationRecord
    include Model::Project
    include Com::Ext::Extra
    include Finance::Ext::Financial if defined? RailsFinance
  end
end
