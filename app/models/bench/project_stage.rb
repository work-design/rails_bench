module Bench
  class ProjectStage < ApplicationRecord
    include RailsBench::ProjectStage
    include RailsFinanceExt::Financial if defined? RailsFinance
  end
end
