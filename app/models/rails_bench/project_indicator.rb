module RailsBench::ProjectIndicator
  extend ActiveSupport::Concern

  included do
    attribute :record_date, :date
    attribute :value, :decimal
    attribute :source, :string
    attribute :comment, :string

    belongs_to :project
    belongs_to :indicator
  end

end
