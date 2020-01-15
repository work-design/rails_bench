require 'rails_com'
module RailsBench
  class Engine < ::Rails::Engine

    config.generators do |g|
      g.rails = {
        assets: false,
        stylesheets: false,
        helper: false,
        jbuilder: true
      }
      g.test_unit = {
        fixture: true,
        fixture_replacement: :factory_girl
      }
      g.templates.unshift File.expand_path('lib/templates', RailsCom::Engine.root)
    end

  end
end
