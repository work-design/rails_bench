class Project < ApplicationRecord
  include RailsBench::Project
end unless defined? Project
