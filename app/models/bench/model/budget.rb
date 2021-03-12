module Bench
  module Model::Budget
    extend ActiveSupport::Concern

    included do
      attribute :amount, :decimal, default: 0
      attribute :note, :string

      belongs_to :task
    end

  end
end
