Rails.application.routes.draw do

  scope module: 'bench' do
    resources :projects do
      member do
        match :github, via: [:get, :post]
      end
      resources :fund_incomes
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
      resources :pictures
      resources :links
    end
    resources :projects do
      member do
        get :tasks
        get :repos
        get :github_hook
      end
      resources :expenses do
        collection do
          get :add_item
          get :remove_item
        end
      end
    end
    resources :task_templates
    resources :facilitates, only: [] do
      member do
        put :order
      end
    end
  end

  scope :admin, module: 'bench/admin', as: :admin do
    resources :project_taxons do
      member do
        get :parameter
      end
      resources :project_preferences do
        collection do
          get :facilitates
          get :providers
        end
      end
    end
    resources :project_stages
    resources :project_states
    resources :projects do
      member do
        get :task_templates
        get :tasks
      end
      resources :fund_uses
      resources :budgets do
        collection do
          get :add_item
          get :remove_item
        end
      end
      resources :expenses do
        collection do
          get :add_item
          get :remove_item
        end
      end
      resources :project_facilitates do
        collection do
          get :facilitates
          get :providers
        end
      end
    end
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
    resources :facilitate_providers do
      member do
        get :task_templates
      end
    end
  end

  scope :panel, module: 'bench/panel', as: :panel do
    resources :facilitate_taxons, except: [:index, :show]
    resources :facilitates do
      resources :facilitate_providers
    end
  end

end
