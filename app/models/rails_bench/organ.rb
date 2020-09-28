module RailsBench::Organ
  extend ActiveSupport::Concern

  included do
    has_many :facilitate_providers, foreign_key: :provider_id, dependent: :destroy
  end

end


