module Bench
  module Model::FacilitateProvider
    extend ActiveSupport::Concern

    included do
      attribute :selected, :boolean, default: false
      attribute :note, :string
      attribute :export_price, :decimal

      belongs_to :facilitate
      belongs_to :provider, class_name: 'Org::Organ'

      has_many :task_templates, as: :tasking, dependent: :nullify
    end

    def sync_price

    end

  end
end
