module Bench
  class Task < ApplicationRecord
    include Model::Task
    include Com::Ext::Taxon
    include Eventual::Ext::Planned if defined? RailsEvent
  end
end
