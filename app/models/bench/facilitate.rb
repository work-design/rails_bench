module Bench
  class Facilitate < ApplicationRecord
    include Model::Facilitate
    include Trade::Ext::Good if defined? RailsTrade
    include Detail::Ext::Listing if defined? RailsDetail
  end
end
