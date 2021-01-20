module Bench
  module Model::ProjectTaxon
    extend ActiveSupport::Concern

    included do
      attribute :record_name, :string
      attribute :name, :string
      attribute :projects_count, :integer, default: 0

      belongs_to :organ, optional: true

      has_many :task_templates, -> { roots }
      has_many :job_titles, through: :task_templates
      has_many :members, through: :task_templates
      has_many :project_taxon_indicators, dependent: :delete_all
      has_many :project_taxon_facilitates, dependent: :delete_all
    end

  end
end
