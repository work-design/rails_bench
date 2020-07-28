class TaskMaster < ApplicationRecord
  include RailsBench::TaskMaster
end unless defined? TaskMaster
