module RailsBench::User
  extend ActiveSupport::Concern
  included do
    attribute :pomodoro, :integer, default: 25
  end

end
