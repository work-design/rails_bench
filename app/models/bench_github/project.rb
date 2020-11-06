module BenchGithub::Project

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

  def github_hook_url
    'http://wechat.one.work/projects/' + self.id.to_s + '/github'
  end

end
