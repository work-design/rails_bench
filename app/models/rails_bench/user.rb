module RailsBench::User
  extend ActiveSupport::Concern

  included do
    attribute :pomodoro, :integer, default: 25
    has_many :tasks, dependent: :destroy
  end

end
