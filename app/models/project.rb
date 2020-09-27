class Project < ApplicationRecord
  include RailsBench::Project
  include RailsFinance::Expendable if defined? RailsFinance
end unless defined? Project
