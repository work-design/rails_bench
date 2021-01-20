module Bench
  class Project < ApplicationRecord
    include RailsBench::Project
    include RailsComExt::Extra
    include RailsFinanceExt::Financial if defined? RailsFinance
  end
end
