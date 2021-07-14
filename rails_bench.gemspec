$:.push File.expand_path('lib', __dir__)
require 'rails_bench/version'

Gem::Specification.new do |s|
  s.name = 'rails_bench'
  s.version = RailsBench::VERSION
  s.authors = ['qinmingyuan']
  s.email = ['mingyuan0715@foxmail.com']
  s.homepage = 'https://github.com/work-design/rails_bench'
  s.summary = 'Summary of RailsBench.'
  s.description = 'Description of RailsBench.'
  s.license = 'MIT'

  s.files = Dir[
    '{app,config,db,lib}/**/*',
    'LICENSE',
    'Rakefile',
    'README.md'
  ]

  s.add_dependency 'rails_com', '~> 1.2'
  s.add_dependency 'rails_org'
  s.add_dependency 'rails_finance'
  s.add_development_dependency 'sqlite3'
end
