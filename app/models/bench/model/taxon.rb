module Bench
  module Model::Taxon
    extend ActiveSupport::Concern

    included do
      attribute :record_name, :string
      attribute :name, :string
      attribute :projects_count, :integer, default: 0

      belongs_to :organ, class_name: 'Org::Organ', optional: true

      has_many :task_templates, -> { roots }
      has_many :job_titles, through: :task_templates
      has_many :members, through: :task_templates
      has_many :projects, dependent: :nullify
      has_many :taxon_indicators, dependent: :delete_all
      has_many :taxon_facilitates, dependent: :delete_all
    end

  end
end
