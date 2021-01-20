module Bench
  module Model::ProjectIndicator
    extend ActiveSupport::Concern

    included do
      attribute :recorded_on, :date
      attribute :recorded_at, :datetime
      attribute :value, :string
      attribute :source, :string
      attribute :comment, :string

      belongs_to :project
      belongs_to :indicator

      enum state: {
        init: 'init',
        checked: 'checked'
      }, _default: 'init'
    end

  end
end
