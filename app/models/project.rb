class Project < ApplicationRecord
  include RailsBench::Project
  include RailsBenchExt::OtherTasking
  include RailsFinanceExt::Expendable if defined? RailsFinance
  include RailsFinanceExt::Budgeting if defined? RailsFinance
end unless defined? Project
