module RailsBench::Project
  extend ActiveSupport::Concern

  included do
    attribute :name, :string
    attribute :description, :string
    attribute :github_repo, :string

    has_many :teams, as: :teaming, dependent: :destroy
    has_many :project_members, dependent: :destroy
    has_many :pipelines, as: :piping, dependent: :destroy
    has_many :project_webhooks, dependent: :delete_all
    has_many :project_funds, dependent: :nullify

    validates :name, presence: true

    has_one_attached :logo
  end

  def get_github_repo
    Rails.cache.fetch "projects/#{self.id}/github_repo" do
      creator&.github_repos(self.github_repo)
    end
  end

  def github_hook_add
    creator.github_client.create_hook(
      get_github_repo[:full_name],
      'web',
      { url: github_hook_url, content_type: 'json'},
      { events: ['push', 'pull_request'], active: true }
    )
  end

  def duties
    Duty.where(id: self.project_members.distinct(:duty_id).pluck(:duty_id))
  end

  def github_hook_url
    'http://wechat.one.work/projects/' + self.id.to_s + '/github'
  end

end
