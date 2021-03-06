Rails.application.routes.draw do

  scope module: 'bench', defaults: { business: 'bench' } do
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

  scope :me, module: 'bench/me', as: :me, defaults: { business: 'bench', namespace: 'me' } do
    resources :tasks, param: :task_id do
      member do
        get :project
      end
    end
    resources :tasks do
      collection do
        get 'template' => :new_template
      end
      member do
        patch :close
        patch :reorder
        get :project
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
        get :repos
        get :github_hook
      end
      resources :expenses
    end
    resources :facilitates, only: [] do
      member do
        put :order
      end
    end
  end

  scope 'bench/admin', module: 'bench/admin', defaults: { business: 'bench', namespace: 'admin' } do
    resources :taxons do
      member do
        get :budgets
        get :expenses
        get :parameter
      end
      resources :task_templates do
        collection do
          get :add
          get :departments
          get :job_titles
          get :members
        end
        member do
          get 'member' => :edit_member
          patch 'member' => :update_member
          patch :reorder
        end
      end
      resources :taxon_facilitates do
        collection do
          get :facilitates
        end
      end
      resources :taxon_indicators do
        collection do
          get :indicators
        end
      end
    end
    resources :project_stages
    resources :project_states
    resources :projects do
      member do
        get :sync
      end
      resources :budgets
      resources :expenses
      resources :project_facilitates do
        collection do
          get :facilitates
          get :providers
        end
      end
      resources :project_indicators
      resources :project_mileposts, except: [:index, :show]
    end
    resources :tasks do
      collection do
        get 'template' => :new_template
        get 'project/:project_id' => :project
      end
      member do
        get :stock
        get :fund
      end
      resources :task_timers do
        member do
          patch :pause
        end
      end
    end
    scope path: ':financial_type/:financial_id' do
      resources :fund_budgets
      resources :fund_expenses
    end
    resources :mileposts do
      member do
        patch :move_lower
        patch :move_higher
      end
    end
    resources :indicators
    resources :facilitate_taxons
    resources :facilitates do
      resources :facilitate_providers
      resources :facilitate_indicators
    end
  end

  scope :org, module: 'bench/org', as: :org do
    resources :facilitates do
      resources :facilitate_providers
    end
  end

end
