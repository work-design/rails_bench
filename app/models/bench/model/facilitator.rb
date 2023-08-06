module Bench
  module Model::Facilitator
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :description, :string

      belongs_to :facilitate
      belongs_to :member, class_name: 'Org::Member'

      has_one_attached :avatar
    end

  end
end
