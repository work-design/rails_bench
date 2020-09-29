class ProjectMember < ApplicationRecord
  include RailsBench::ProjectMember
end unless defined? ProjectMember
