module Bench
  class TaskTemplate < ApplicationRecord
    include RailsCom::Taxon
    include RailsBench::TaskTemplate
  end
end
