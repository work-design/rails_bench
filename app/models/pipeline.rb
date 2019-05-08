class Pipeline < ApplicationRecord
  include RailsBench::Pipeline
end unless defined? Pipeline
