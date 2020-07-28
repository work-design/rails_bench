class Task < ApplicationRecord
  prepend RailsTaxon::Node
  include RailsDetail::ContentModel if defined? RailsDetail
  include RailsEvent::Planned if defined? RailsEvent
  include RailsBench::Task
end unless defined? Task
