module Bench
  module Ext::Organ
    extend ActiveSupport::Concern

    included do
      has_many :facilitate_providers, class_name: 'Bench::FacilitateProvider', foreign_key: :provider_id
    end

  end
end
