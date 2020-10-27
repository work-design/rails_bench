module RailsBench::ProjectTaxon
  extend ActiveSupport::Concern

  included do
    attribute :name, :string
    attribute :projects_count, :integer, default: 0

    has_many :project_taxon_indicators, dependent: :delete_all
    has_many :project_taxon_facilitates, dependent: :delete_all
  end

end
