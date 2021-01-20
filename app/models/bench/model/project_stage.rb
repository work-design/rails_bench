module Bench
  module Model::ProjectStage
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :begin_on, :date
      attribute :end_on, :date
      attribute :note, :string
      attribute :projects_count, :integer

      has_many :projects, dependent: :nullify
    end

  end
end
