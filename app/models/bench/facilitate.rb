module Bench
  class Facilitate < ApplicationRecord
    include RailsBench::Facilitate
    include RailsTrade::Good if defined? RailsTrade
    include RailsFactory::Good if defined? RailsFactory
  end
end
