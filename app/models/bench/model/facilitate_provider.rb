module Bench
  module Model::FacilitateProvider
    extend ActiveSupport::Concern

    included do
      attribute :note, :string
      attribute :selected, :boolean, default: true

      belongs_to :facilitate
      belongs_to :provider, class_name: 'Org::Organ'
    end

  end
end
