module RailsBench::Member
  include RailsRole::User
  extend ActiveSupport::Concern
  included do
    attribute :major, :boolean
    
    belongs_to :user
    belongs_to :duty
    belongs_to :provider, optional: true
    has_many :task_workers
    has_many :tasks, through: :task_workers
    has_many :project_members, dependent: :nullify
    has_many :projects, through: :project_members
  
    delegate :name, :avatar, to: :user, prefix: true
  
    def set_major
      self.class.transaction do
        self.update(major: true)
        Worker.where.not(id: self.id).where(user_id: self.user_id).update_all(major: false)
      end
    end
  end
  
end



