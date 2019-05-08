class PipelineMember < ApplicationRecord
  include RailsBench::PipelineMember
end unless defined? PipelineMember
