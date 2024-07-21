module Bench
  module Model::ProjectFacilitate
    extend ActiveSupport::Concern

    included do
      belongs_to :project
      belongs_to :facilitate_taxon
      belongs_to :facilitate

      belongs_to :provider, class_name: 'Org::Organ', optional: true
      belongs_to :facilitate_provider, ->(o) { where(facilitate_id: o.facilitate_id) }, foreign_key: :provider_id, primary_key: :provider_id, optional: true

      before_validation :sync_facilitate_taxon, if: -> { facilitate_id_changed?}
    end

    def sync_facilitate_taxon
      self.facilitate_taxon_id = facilitate&.facilitate_taxon_id
    end

  end
end
