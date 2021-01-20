module Bench
  class Task < ApplicationRecord
    include Com::Ext::Taxon
    include RailsDetail::ContentModel if defined? RailsDetail
    include Event::Model::Planned if defined? RailsEvent
    include RailsBench::Task
  end
end
