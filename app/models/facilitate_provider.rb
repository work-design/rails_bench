class FacilitateProvider < ApplicationRecord
  include RailsBench::FacilitateProvider
  include RailsBenchExt::OtherTasking
end unless defined? FacilitateProvider
