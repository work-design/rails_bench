module Bench
  module Model::User
    extend ActiveSupport::Concern

    included do
      attribute :pomodoro, :integer, default: 25

      has_one :github_user
      has_many :tasks, dependent: :destroy
    end

    def github_client
      github_user.client
    end

    def github_repos(name = nil)
      if github_user && name
        github_user.client.repo(name)
      elsif github_user && name.nil?
        github_user.client.repos.map { |r| { full_name: r.full_name, private: r.private } }
      else
        []
      end
    end

  end
end
