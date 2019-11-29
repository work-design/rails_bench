module RailsBench::ProjectFund
  extend ActiveSupport::Concern
  included do
    attribute :visible, :boolean, default: true
    
    belongs_to :project
    belongs_to :user
  
    after_create_commit :get_order
  end
  
end
