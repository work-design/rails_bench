module RailsBench::FacilitateIndicator
  extend ActiveSupport::Concern

  included do
    attribute :note, :string

    belongs_to :facilitate
    belongs_to :indicator_taxon
    belongs_to :indicator
  end

end
