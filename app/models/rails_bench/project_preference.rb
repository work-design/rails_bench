module RailsBench::ProjectPreference
  extend ActiveSupport::Concern

  included do
    belongs_to :project_taxon
    belongs_to :facilitate
    belongs_to :provider, class_name: 'Organ', optional: true
    belongs_to :facilitate_provider, ->(o) { where(facilitate_id: o.facilitate_id) }, foreign_key: :provider_id, primary_key: :provider_id, optional: true
  end

end
