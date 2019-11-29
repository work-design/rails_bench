class Task < ApplicationRecord
  prepend RailsTaxon::Node
  include RailsDetail::ContentModel
  include RailsEvent::Planned
  include RailsBench::Task
end unless defined? Task
