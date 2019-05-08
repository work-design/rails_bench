class Task < ApplicationRecord
  include RailsBench::Task
end unless defined? Task
