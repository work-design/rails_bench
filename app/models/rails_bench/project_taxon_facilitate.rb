module RailsBench::ProjectTaxonFacilitate
  extend ActiveSupport::Concern

  included do
    belongs_to :project_taxon
    belongs_to :facilitate_taxon
    belongs_to :facilitate
  end

end
