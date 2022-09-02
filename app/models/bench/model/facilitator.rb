module Bench
  module Model::Facilitator
    extend ActiveSupport::Concern

    included do
      attribute :name, :string

      belongs_to :facilitate
      belongs_to :member, class_name: 'Org::Member'
    end

  end
end
