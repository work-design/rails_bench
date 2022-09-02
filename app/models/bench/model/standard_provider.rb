module Bench
  module Model::StandardProvider
    extend ActiveSupport::Concern

    included do
      attribute :selected, :boolean, default: false
      attribute :note, :string
      attribute :export_price, :decimal

      belongs_to :facilitate

      has_many :task_templates, as: :tasking, dependent: :nullify
    end

    def sync_price

    end

  end
end
