class TaskTemplate < ApplicationRecord
  prepend RailsTaxon::Node
  include RailsBench::TaskTemplate
end unless defined? TaskTemplate
