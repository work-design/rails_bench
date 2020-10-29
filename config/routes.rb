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

  scope :me, module: 'bench/me', as: :me, defaults: { namespace: 'me', business: 'bench' } do
    resources :tasks do
      collection do
        get 'template' => :new_template
        get 'project/:project_id' => :project
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

  scope :admin, module: 'bench/admin', as: :admin, defaults: { namespace: 'admin', business: 'bench' } do
    resources :project_taxons do
      member do
        get :parameter
      end
      resources :project_taxon_facilitates do
        collection do
          get :facilitates
        end
      end
      resources :project_taxon_indicators do
        collection do
          get :indicators
        end
      end
    end
    resources :project_stages
    resources :project_states
    resources :projects do
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
      resources :project_indicators
      resources :project_mileposts, except: [:index, :show]
    end
    resources :tasks do
      collection do
        get 'project/:project_id' => :project
      end
    end
    resources :task_templates do
      collection do
        get :add
        get :members
        get 'project/:project_id' => :project
      end
      member do
        get 'member' => :edit_member
        patch 'member' => :update_member
        patch :reorder
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
    resources :facilitate_taxons, except: [:index, :show]
    resources :facilitates do
      resources :facilitate_providers do
        member do
          get :task_templates
        end
      end
      resources :facilitate_indicators
    end
  end

  scope :provider, module: 'provider/admin', as: :provider do
    resources :facilitates do
      resources :facilitate_providers
    end
  end

end
