module Bench
  module Model::FacilitateIndicator
    extend ActiveSupport::Concern

    included do
      attribute :note, :string

      belongs_to :facilitate
      belongs_to :facilitate_taxon
      belongs_to :indicator

      before_validation :sync_facilitate_taxon, if: -> { new_record? || indicator_id_changed? }
    end

    def sync_facilitate_taxon
      self.facilitate_taxon = indicator.facilitate_taxon
    end

  end
end
