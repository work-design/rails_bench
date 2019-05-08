module RailsBench::TaskTemplate
  extend ActiveSupport::Concern
  included do
    acts_as_list
    belongs_to :tasking, polymorphic: true
    belongs_to :pipeline, optional: true
  
    scope :ordered, -> { order(position: :asc) }
  end
  
end
