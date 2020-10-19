class TaskTemplate < ApplicationRecord
  include RailsCom::Taxon
  include RailsBench::TaskTemplate
end unless defined? TaskTemplate
