module Bench
  module Model::TaskTemplate
    extend ActiveSupport::Concern

    included do
      attribute :title, :string
      attribute :position, :integer
      attribute :color, :string
      attribute :repeat_type, :string, default: 'once'
      attribute :repeat_days, :integer, array: true

      belongs_to :taxon, optional: true

      belongs_to :organ, class_name: 'Org::Organ', optional: true
      belongs_to :department, class_name: 'Org::Department', optional: true
      belongs_to :job_title, class_name: 'Org::JobTitle', optional: true
      belongs_to :member, class_name: 'Org::Member', optional: true

      acts_as_list scope: [:organ_id, :taxon_id, :parent_id]
    end

  end
end
