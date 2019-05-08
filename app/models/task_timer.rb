class TaskTimer < ApplicationRecord
  include RailsBench::TaskTimer
end unless defined? TaskTimer
