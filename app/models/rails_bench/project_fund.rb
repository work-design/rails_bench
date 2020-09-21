module RailsBench::ProjectFund
  extend ActiveSupport::Concern

  included do
    attribute :amount, :decimal
    attribute :visible, :boolean, default: true
    attribute :note, :string

    belongs_to :project
    belongs_to :user

    has_one_attached :proof

    #after_create_commit :get_order
  end

end
