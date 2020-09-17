module RailsBench::ProjectFund
  extend ActiveSupport::Concern

  included do
    attribute :amount, :decimal
    attribute :visible, :boolean, default: true

    belongs_to :project
    belongs_to :user

    #after_create_commit :get_order
  end

end
