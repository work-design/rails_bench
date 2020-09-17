class TaskTemplate < ApplicationRecord
  include RailsTaxon::Node
  include RailsBench::TaskTemplate
end unless defined? TaskTemplate
