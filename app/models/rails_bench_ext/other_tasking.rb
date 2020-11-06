module RailsBenchExt::OtherTasking
  extend ActiveSupport::Concern

  included do
    attribute :record_name, :string, default: self.name
  end

end
