module Bench
  class Task < ApplicationRecord
    include Model::Task
    include Com::Ext::Taxon
    include RailsDetail::ContentModel if defined? RailsDetail
    include Event::Model::Planned if defined? RailsEvent
  end
end
