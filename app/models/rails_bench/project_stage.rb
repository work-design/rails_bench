module RailsBench::ProjectStage
  extend ActiveSupport::Concern

  included do
    attribute :name, :string
    attribute :begin_on, :date
    attribute :finish_on, :date
    attribute :state, :string
  end


end
