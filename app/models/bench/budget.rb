module Bench
  class Budget < ApplicationRecord
    self.table_name = 'finance_budgets'
    include Model::Budget
  end
end
