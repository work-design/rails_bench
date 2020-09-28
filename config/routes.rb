Rails.application.routes.draw do

  scope module: 'bench' do
    resources :projects do
      match :github, on: :member, via: [:get, :post]
    end
    resources :facilitates, only: [:index, :show] do
      collection do
        get :buy
      end
    end
  end

  scope :me, module: 'bench/me', as: :me do
    resources :tasks do
      collection do
        get 'template' => :new_template
      end
      member do
        patch :close
        patch :reorder
        get 'done' => :edit_done
        patch 'done' => :update_done
        patch :rework
        get 'focus' => :edit_focus
        get 'assign' => :edit_assign
      end
      resources :task_timers do
        member do
          patch :pause
        end
      end
      resources :task_members
      resources :pictures
      resources :links
    end
    resources :teams do
      resources :team_members, path: 'members', as: 'members' do
        collection do
          get :search
        end
        member do
          get :members
          get 'member' => :edit_member
          patch 'member' => :update_member
        end
      end
    end
    resources :projects do
      member do
        get :tasks
        get :repos
        get :github_hook
        get :task_templates
      end
      resources :project_members, path: 'members', as: 'members' do
        collection do
          get :search
        end
        member do
          get :members
          get 'member' => :edit_member
          patch 'member' => :update_member
        end
      end
      resources :project_funds, path: 'funds', as: 'funds'
      resources :expenses
    end
    resources :task_templates
    resources :facilitates, only: [] do
      member do
        put :order
      end
    end
    resources :facilitate_providers do
      member do
        get :task_templates
      end
    end
  end

  scope :admin, module: 'bench/admin', as: :admin do
    resources :project_taxons do
      member do
        get :parameter
      end
    end
    resources :project_stages
    resources :project_states
    resources :projects
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
    resources :facilitate_taxons, except: [:index, :show]
    resources :facilitates
  end

end
