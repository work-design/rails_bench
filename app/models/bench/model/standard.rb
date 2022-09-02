module Bench
  module Model::Standard
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
    end

  end
end
