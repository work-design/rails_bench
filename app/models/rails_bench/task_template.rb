module RailsBench::TaskTemplate
  extend ActiveSupport::Concern

  included do
    attribute :title, :string
    attribute :position, :integer
    attribute :color, :string
    attribute :parent_id, :integer

    belongs_to :project_taxon, optional: true
    belongs_to :organ, optional: true
    belongs_to :job_title, optional: true
    belongs_to :member, optional: true

    acts_as_list scope: [:organ_id, :project_taxon, :parent_id]
  end

end
