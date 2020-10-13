class Project < ApplicationRecord
  include RailsBench::Project
  include RailsBenchExt::OtherTasking
  include RailsFinanceExt::Financial if defined? RailsFinance
end unless defined? Project
