class Log < ApplicationRecord
  include RailsBench::Log
end unless defined? Log
