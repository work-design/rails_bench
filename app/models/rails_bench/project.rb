module RailsBench::Project
  extend ActiveSupport::Concern

  included do
    attribute :name, :string
    attribute :description, :string
    attribute :state, :string

    belongs_to :organ, optional: true
    belongs_to :project_taxon, counter_cache: true, optional: true
    belongs_to :taxon, class_name: 'ProjectTaxon', foreign_key: :project_taxon_id
    has_many :project_owners, -> { where(owned: true) }, class_name: 'ProjectMember'
    has_many :owners, through: :project_owners, source: :member
    has_many :project_members, dependent: :destroy
    has_many :project_webhooks, dependent: :delete_all
    has_many :tasks, as: :tasking
    has_many :project_indicators, dependent: :destroy
    has_many :project_facilitates, dependent: :destroy
    has_many :project_mileposts, dependent: :delete_all

    validates :name, presence: true

    after_save :sync_facilitates_from_project_taxon, if: -> { saved_change_to_project_taxon_id? && !project_taxon_id.blank? }

    has_one_attached :logo
  end

  def get_github_repo
    Rails.cache.fetch "projects/#{self.id}/github_repo" do
      creator.user.github_repos(self.github_repo)
    end
  end

  def github_hook_add
    creator.user.github_client.create_hook(
      get_github_repo[:full_name],
      'web',
      { url: github_hook_url, content_type: 'json'},
      { events: ['push', 'pull_request'], active: true }
    )
  end

  def duties
    JobTitle.where(id: self.project_members.distinct(:job_title_id).pluck(:job_title_id))
  end

  def github_hook_url
    'http://wechat.one.work/projects/' + self.id.to_s + '/github'
  end

  # project_preferences -> project_facilitates
  def sync_facilitates_from_project_taxon
    project_taxon.project_preferences.each do |project_preference|
      p = project_preference.slice(:facilitate_taxon_id, :facilitate_id, :provider_id)
      project_facilitates.find_or_create_by(p)
    end
  end
end
