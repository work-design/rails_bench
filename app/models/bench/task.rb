module Bench
  class Task < ApplicationRecord
    include Model::Task
    include Com::Ext::Taxon
    include Detail::Model::ContentModel if defined? RailsDetail
    include Eventual::Model::Planned if defined? RailsEvent
  end
end
