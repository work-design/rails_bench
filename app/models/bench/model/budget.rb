module Bench
  module Model::Budget
    extend ActiveSupport::Concern

    included do
      belongs_to :task
    end

  end
end
