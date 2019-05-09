class Task < ApplicationRecord
  include RailsDetail::ContentModel
  include RailsBooking::Plan
  include RailsBench::Task
end unless defined? Task
