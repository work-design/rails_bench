class ProjectTaxon < ApplicationRecord
  include RailsBench::ProjectTaxon
  include RailsComExt::Parameter
end unless defined? ProjectTaxon
