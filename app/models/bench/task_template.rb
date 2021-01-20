module Bench
  class TaskTemplate < ApplicationRecord
    include Com::Ext::Taxon
    include Model::TaskTemplate
  end
end
