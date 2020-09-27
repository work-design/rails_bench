module RailsBench::ProjectTaxon
  extend ActiveSupport::Concern

  included do
    attribute :name, :string

    has_many :task_templates, -> { roots }, as: :tasking
  end

end
