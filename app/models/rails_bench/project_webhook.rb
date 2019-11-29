module RailsBench::ProjectWebhook
  extend ActiveSupport::Concern

  included do
    attribute :origin_data, :json
    attribute :valuable_data, :json
    
    belongs_to :project
  end

end
