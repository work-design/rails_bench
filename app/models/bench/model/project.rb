module RailsBench::Project
  extend ActiveSupport::Concern

  included do
    attribute :name, :string
    attribute :description, :string
    attribute :state, :string

    belongs_to :organ, optional: true
    belongs_to :project_taxon, counter_cache: true, optional: true
    belongs_to :taxon, class_name: 'ProjectTaxon', foreign_key: :project_taxon_id
    has_many :project_webhooks, dependent: :delete_all
    has_many :tasks, dependent: :delete_all
    has_many :project_indicators, dependent: :destroy
    has_many :project_facilitates, dependent: :destroy
    has_many :project_mileposts, dependent: :delete_all
    has_many :mileposts, through: :project_mileposts

    validates :name, presence: true

    #after_save :sync_facilitates_from_project_taxon, if: -> { saved_change_to_project_taxon_id? && !project_taxon_id.blank? }

    has_one_attached :logo
  end

  def init_tasks
    serial_number = UidHelper.usec_uuid('T')
    project_taxon.task_templates.each do |task_template|
      tasks.build(task_template_id: task_template.id, serial_number: serial_number)
    end
  end

  # project_preferences -> project_facilitates
  def sync_facilitates_from_project_taxon
    project_taxon.project_taxon_preferences.each do |project_preference|
      p = project_taxon_preference.slice(:facilitate_taxon_id, :facilitate_id, :provider_id)
      project_facilitates.find_or_create_by(p)
    end
  end

end
