module RailsBench::ProjectTaxon
  extend ActiveSupport::Concern

  included do
    attribute :name, :string

  end

end