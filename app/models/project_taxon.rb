class ProjectTaxon < ApplicationRecord
  include RailsBench::ProjectTaxon
  include RailsBenchExt::OtherTasking
  include RailsComExt::Parameter
end unless defined? ProjectTaxon
