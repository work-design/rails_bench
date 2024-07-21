Rails.application.routes.draw do
  scope RailsCom.default_routes_scope do
    concern :tasked do
      collection do
        get 'template' => :new_template
      end
      member do
        patch :close
        patch :reorder
        patch :child
        get :project
        get 'done' => :edit_done
        patch 'done' => :update_done
        patch :rework
        post :edit_focus
        post :edit_assign
        match :estimated, via: [:get, :post]
        match :stock, via: [:get, :post]
        match :fund, via: [:get, :post]
        match :member, via: [:get, :post]
        match :deadline, via: [:get, :post]
      end
      resources :task_timers do
        member do
          patch :pause
        end
      end
      resources :pictures
      resources :links
    end

    namespace 'bench', defaults: { business: 'bench' } do
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
        resources :facilitators
      end
      resources :facilitatings do
        member do
          get :qrcode
        end
      end

      namespace :me, defaults: { namespace: 'me' } do
        resources :tasks do
          concerns :tasked
        end
        resources :projects do
          member do
            get :repos
            get :github_hook
          end
          resources :expenses
        end
        resources :facilitates, only: []
        resources :facilitatings do
          member do
            get :qrcode
            patch :start
            patch :finish
          end
        end
      end

      namespace :my, defaults: { namespace: 'my' } do
        resources :items, only: [] do
          resources :facilitatings
        end
      end

      namespace 'admin', defaults: { namespace: 'admin' } do
        root 'home#index'
        resources :facilitate_taxons
        resources :facilitates do
          member do
            match :wallet, via: [:get, :post]
            patch :update_wallet
            match :card, via: [:get, :post]
            patch :update_card
          end
          resources :facilitators
          resources :facilitate_indicators
          resources :facilitate_providers
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
            get 'project/:project_id' => :project
          end
          concerns :tasked
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
      end

      namespace :panel, defaults: { namespace: 'panel' } do
        root 'home#index'
        resources :taxons do
          member do
            get :budgets
            get :expenses
            match :parameter, via: [:get, :post]
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
          resources :projects
        end
        resources :indicators
        resources :standards do
          resources :standard_providers
        end
      end

      namespace :org, defaults: { namespace: 'org' } do
        resources :facilitates do
          resources :facilitate_providers
        end
      end
    end
  end
  resolve 'Bench::Facilitate' do |facilitate, options|
    [:bench, facilitate, options]
  end
end
