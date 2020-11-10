class Facilitate < ApplicationRecord
  include RailsBench::Facilitate
  include RailsTrade::Good if defined? RailsTrade
  include RailsFactory::Good if defined? RailsFactory
end unless defined? Facilitate
