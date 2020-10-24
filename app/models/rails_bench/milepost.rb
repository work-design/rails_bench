module RailsBench::Milepost
  extend ActiveSupport::Concern

  included do
    attribute :name, :string
    attribute :position, :integer
    attribute :project_mileposts_count, :integer


    belongs_to :organ, optional: true
    has_many :project_mileposts, dependent: :delete_all
    has_many :projects, through: :project_mileposts

    default_scope -> { order(position: :asc) }

    acts_as_list scope: [:organ_id]
  end


end
