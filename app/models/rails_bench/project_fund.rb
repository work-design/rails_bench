module RailsBench::ProjectFund
  extend ActiveSupport::Concern

  included do
    attribute :amount, :decimal
    attribute :visible, :boolean, default: true
    attribute :note, :string

    belongs_to :project
    belongs_to :user

    has_one_attached :proof

    after_save :sum_amount, if: -> { saved_change_to_amount? }
  end

  def sum_amount
    project.compute_fund_amount
    project.save
  end

end
