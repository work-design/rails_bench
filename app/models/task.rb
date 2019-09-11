class Task < ApplicationRecord
  include RailsDetail::ContentModel
  include RailsEvent::Planned
  include RailsBench::Task
end unless defined? Task
