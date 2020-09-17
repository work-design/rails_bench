module RailsBench::TaskTemplate
  extend ActiveSupport::Concern

  included do
    attribute :title, :string
    attribute :position, :integer
    attribute :color, :string
    attribute :parent_id, :integer

    belongs_to :organ, optional: true
    belongs_to :tasking, polymorphic: true, optional: true
    belongs_to :pipeline, optional: true
    belongs_to :job_title, optional: true
    belongs_to :member, optional: true

    acts_as_list scope: [:organ_id, :tasking_type, :tasking_id, :parent_id]

    before_validation do
      self.tasking_type ||= parent&.tasking_type
      self.tasking_id ||= parent&.tasking_id
    end
  end

end
