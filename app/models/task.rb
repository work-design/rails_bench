class Task < ApplicationRecord
  include RailsCom::Taxon
  include RailsDetail::ContentModel if defined? RailsDetail
  include RailsEvent::Planned if defined? RailsEvent
  include RailsBench::Task
end unless defined? Task
