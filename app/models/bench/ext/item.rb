module Bench
  module Ext::Item
    extend ActiveSupport::Concern

    included do
      has_many :servings, class_name: 'Bench::Serving'
    end

  end
end
