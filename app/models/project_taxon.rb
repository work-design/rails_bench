class ProjectTaxon < ApplicationRecord
  include RailsBench::ProjectTaxon
  include RailsComExt::Parameter
  include RailsBench::Tasking
end unless defined? ProjectTaxon
