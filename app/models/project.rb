class Project < ApplicationRecord
  include RailsBench::Project
  include RailsBenchExt::OtherTasking
  include RailsComExt::Extra
  include RailsFinanceExt::Financial if defined? RailsFinance
end unless defined? Project
