class Facilitate < ApplicationRecord
  include RailsBench::Facilitate
  include RailsTrade::Sell if defined? RailsTrade
  include RailsFactory::Good if defined? RailsFactory
end unless defined? Facilitate
