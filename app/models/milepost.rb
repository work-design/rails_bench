class Milepost < ApplicationRecord
  include RailsBench::Milepost
end unless defined? Milepost
