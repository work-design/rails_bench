module RailsBench::TaskTemplate
  extend ActiveSupport::Concern

  included do
    attribute :title, :string
    attribute :parent_id, :integer
    attribute :position, :integer

    belongs_to :tasking, polymorphic: true
    belongs_to :pipeline, optional: true
  
    scope :ordered, -> { order(position: :asc) }

    acts_as_list
  end
  
end
