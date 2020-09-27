class Project < ApplicationRecord
  include RailsBench::Project
  include RailsBenchExt::OtherTasking
  include RailsFinance::Expendable if defined? RailsFinance
end unless defined? Project
