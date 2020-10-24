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

    after_save_commit :sync_name_to_project_mileposts, if: ->{ saved_change_to_name? }

    acts_as_list scope: [:organ_id]
  end

  def sync_name_to_project_mileposts
    project_mileposts.update_all(milepost_name: name)
  end

end
