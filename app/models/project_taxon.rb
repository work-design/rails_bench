class ProjectTaxon < ApplicationRecord
  include RailsBench::ProjectTaxon
  include RailsComExt::Parameter
  include RailsBenchExt::Tasking
end unless defined? ProjectTaxon
