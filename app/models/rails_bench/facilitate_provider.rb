module RailsBench::FacilitateProvider
  extend ActiveSupport::Concern

  included do
    attribute :selected, :boolean, default: false
    attribute :note, :string
    attribute :export_price, :decimal

    belongs_to :facilitate
    belongs_to :provider, class_name: 'Organ'

    has_many :task_templates, as: :tasking, dependent: :nullify
  end

  def sync_price
    
  end

end
