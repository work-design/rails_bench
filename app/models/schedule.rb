class Schedule < ApplicationRecord
  include RailsBench::Schedule
end unless defined? Schedule
