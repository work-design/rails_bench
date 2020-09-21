class Project < ApplicationRecord
  include RailsBench::Project
  include RailsBench::Tasking
  include RailsFinance::Expendable if defined? RailsFinance
end unless defined? Project
