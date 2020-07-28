module RailsBench::TaskMember
  extend ActiveSupport::Concern

  included do
    attribute :position, :integer
    attribute :current, :boolean, default: false

    belongs_to :task
    belongs_to :member
  end

end
