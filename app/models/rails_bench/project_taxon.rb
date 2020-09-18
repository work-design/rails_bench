module RailsBench::ProjectTaxon
  extend ActiveSupport::Concern

  included do
    attribute :name, :string
    attribute :parameters, :json

  end

end
