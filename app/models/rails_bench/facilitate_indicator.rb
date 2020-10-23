module RailsBench::FacilitateIndicator
  extend ActiveSupport::Concern

  included do

    belongs_to :facilitate
    belongs_to :indicator
  end

end
