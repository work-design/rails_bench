module RailsBench::TaskTemplate
  extend ActiveSupport::Concern

  included do
    attribute :title, :string
    attribute :parent_id, :integer
    attribute :position, :integer

    belongs_to :organ, optional: true
    belongs_to :tasking, polymorphic: true
    belongs_to :pipeline, optional: true

    acts_as_list
  end

end
