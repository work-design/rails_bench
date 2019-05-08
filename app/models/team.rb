class Team < ApplicationRecord
  include RailsBench::Team
end unless defined? Team
