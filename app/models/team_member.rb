class TeamMember < ApplicationRecord
  include RailsBench::TeamMember
end unless defined? TeamMember
