class ProjectWebhook < ApplicationRecord
  include RailsBench::ProjectWebhook
end unless defined? ProjectWebhook
