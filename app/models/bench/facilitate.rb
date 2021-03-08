module Bench
  class Facilitate < ApplicationRecord
    include Model::Facilitate
    include Trade::Model::Good if defined? RailsTrade
    include Factory::Model::Good if defined? RailsFactory
    include Detail::Ext::Listing if defined? RailsDetail
  end
end
