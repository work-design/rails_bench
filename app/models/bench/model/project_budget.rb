module Bench
  module Model::ProjectBudget
    extend ActiveSupport::Concern

    included do
      attribute :amount, :decimal, default: 0
      attribute :note, :string

      belongs_to :fund
      belongs_to :project

      after_save :sum_fund_amount, if: -> { saved_change_to_amount? }
    end

    def sum_fund_amount
      fund.sum_budget_amount(financial_type)
      fund.save
      if financial
        financial.compute_fund_budget
        financial.save
      end
    end

  end
end
