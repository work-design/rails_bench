module RailsBench::TaskMaster
  extend ActiveSupport::Concern

  included do
    attribute :tasking_type, :string
    attribute :position, :integer

    belongs_to :member

    acts_as_list
  end

end
