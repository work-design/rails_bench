Rails.application.routes.draw do

  scope module: 'bench' do
    resources :projects do
      match :github, on: :member, via: [:get, :post]
    end
  end

  scope :me, module: 'bench/me', as: :me do
    resources :tasks do
      collection do
        get :add
      end
      member do
        patch :close
        patch :reorder
        patch :next
        patch :rework
        get 'focus' => :edit_focus
        get 'assign' => :edit_assign
      end
      resources :task_timers do
        patch :pause, on: :member
      end
      resources :task_members
      resources :pictures
      resources :links
    end
    resources :teams do
      resources :team_members, path: 'members', as: 'members' do
        get :search, on: :collection
        get :members, on: :member
        get 'member' => :edit_member, on: :member
        patch 'member' => :update_member, on: :member
      end
    end
    resources :projects do
      get :tasks, on: :member
      get :repos, on: :member
      get :github_hook, on: :member
      resources :project_members, path: 'members', as: 'members' do
        get :search, on: :collection
        get :members, on: :member
        get 'member' => :edit_member, on: :member
        patch 'member' => :update_member, on: :member
      end
      resources :project_funds, path: 'funds', as: 'funds' do

      end
    end
    resources :pipelines
  end

  scope :admin, module: 'bench/admin', as: :admin do
    resources :project_taxons
    resources :project_
    resources :task_templates do
      collection do
        get :add
        get :members
      end
      member do
        get 'member' => :edit_member
        patch 'member' => :update_member
        patch :reorder
      end
    end
  end

end
