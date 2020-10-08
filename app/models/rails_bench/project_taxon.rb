module RailsBench::ProjectTaxon
  extend ActiveSupport::Concern

  included do
    attribute :name, :string

    has_many :project_preferences, dependent: :destroy
  end

end
