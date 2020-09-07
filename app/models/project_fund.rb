class ProjectFund < ApplicationRecord
  include RailsBench::ProjectFund
  include RailsTrade::Sell if defined? RailsTrade
end unless defined? ProjectFund
