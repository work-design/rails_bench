Rails.application.routes.draw do

  scope module: 'bench' do
    resources :projects do
      match :github, on: :member, via: [:get, :post]
    end
  end

  scope :my, module: 'bench/my', as: 'my' do
    resources :task_templates
    resources :tasks do
      patch :close, on: :member
      patch :reorder, on: :member
      patch :current, on: :member
      patch :next, on: :member
      patch :rework, on: :member
      patch :project_id, on: :member
      get 'focus' => :edit_focus, on: :member
      patch 'focus' => :update_focus, on: :member
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

  scope :admin, module: 'bench/admin', as: 'admin' do
    resources :pipelines do
      get :options, on: :collection
      get :members, on: :member
      resources :pipeline_members, path: 'members', as: 'members' do
        member do
          get 'member' => :edit_member
          patch 'member' => :update_member
          patch :reorder
        end
      end
    end
  end

end
