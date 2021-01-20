module Bench
  class Facilitate < ApplicationRecord
    include Model::Facilitate
    include Trade::Model::Good if defined? RailsTrade
    include Factory::Model::Good if defined? RailsFactory
  end
end
