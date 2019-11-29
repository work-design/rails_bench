class ProjectFund < ApplicationRecord
  include RailsBench::ProjectFund
  include RailsTrade::Sell
end unless defined? ProjectFund
