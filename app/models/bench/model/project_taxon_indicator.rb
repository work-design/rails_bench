module RailsBench::ProjectTaxonIndicator
  extend ActiveSupport::Concern

  included do
    belongs_to :project_taxon
    belongs_to :facilitate_taxon
    belongs_to :indicator
  end

end
