module RailsBench::FacilitateIndicator
  extend ActiveSupport::Concern

  included do
    attribute :value, :string
    attribute :note, :string

    belongs_to :facilitate
    belongs_to :indicator
  end

end
