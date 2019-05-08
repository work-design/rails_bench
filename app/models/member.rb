class Member < ApplicationRecord
  include RailsBench::Member
end unless defined? Member
