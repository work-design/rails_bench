class Project < ApplicationRecord
  include RailsBench::Project
  include RailsBench::Tasking
end unless defined? Project
