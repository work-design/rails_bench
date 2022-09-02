module Bench
  module Ext::Item
    extend ActiveSupport::Concern

    included do
      has_many :facilitatings, class_name: 'Bench::Facilitating'
    end

  end
end
