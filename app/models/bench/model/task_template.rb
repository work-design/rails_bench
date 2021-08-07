module Bench
  module Model::TaskTemplate
    extend ActiveSupport::Concern

    included do
      attribute :title, :string
      attribute :position, :integer
      attribute :color, :string
      attribute :repeat_type, :string, default: 'once'
      attribute :repeat_days, :integer, array: true

      belongs_to :project_taxon, optional: true
      belongs_to :organ, optional: true
      belongs_to :department, optional: true
      belongs_to :job_title, optional: true
      belongs_to :member, optional: true
      belongs_to :taxon, optional: true

      acts_as_list scope: [:organ_id, :project_taxon, :parent_id]
    end

  end
end
