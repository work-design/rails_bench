module RailsBench::Milepost
  extend ActiveSupport::Concern

  included do
    attribute :name, :string
    attribute :position, :integer
    attribute :project_mileposts_count, :integer

    has_many :project_mileposts, dependent: :delete_all
    has_many :projects, through: :project_mileposts
  end


end
