module RailsBench::ProjectTaxon
  extend ActiveSupport::Concern

  included do
    attribute :name, :string
    attribute :projects_count, :integer

    has_many :project_preferences, dependent: :destroy
  end

end
