module RailsBench::Team
  extend ActiveSupport::Concern
  included do
    belongs_to :teaming, polymorphic: true, optional: true
    has_many :team_members, dependent: :delete_all
    has_many :members, through: :team_members
  end
  
end
