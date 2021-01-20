module Bench
  class ProjectStage < ApplicationRecord
    include Model::ProjectStage
    include RailsFinanceExt::Financial if defined? RailsFinance
  end
end
