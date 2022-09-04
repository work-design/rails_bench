module Bench
  class Facilitate < ApplicationRecord
    include Trade::Ext::Good if defined? RailsTrade
    include Model::Facilitate
    include Factory::Model::Good if defined? RailsFactory
    include Detail::Ext::Listing if defined? RailsDetail
  end
end
