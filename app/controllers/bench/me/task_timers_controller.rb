class Bench::Me::TaskTimersController < Bench::Admin::TaskTimersController

  def self.local_prefixes
    [controller_path, 'bench/me/base', 'bench/admin/tasks', 'bench/admin/base']
  end


end
