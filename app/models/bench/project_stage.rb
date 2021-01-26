module Bench
  class ProjectStage < ApplicationRecord
    include Model::ProjectStage
    include Finance::Ext::Financial if defined? RailsFinance
  end
end
