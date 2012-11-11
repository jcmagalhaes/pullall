Gem::Specification.new do |s|
  s.name        = 'pullall'
  s.version     = '0.1.1'
  s.summary     = "Pullall"
  s.description = "Pull all the repositories that belong to a group you defined"
  s.authors     = ["João Magalhães"]
  s.email       = ['joao@iterar.co', 'joao@savantstudio.co.uk']
  s.files       = %w[
    bin/pullall
    lib/pullall.rb
    lib/pullall/actions.rb
    lib/pullall/lib_trollop.rb
  ]
  s.add_dependency('oj', '~> 1.4.4')
  s.executables = ["pullall"]
  s.homepage    = 'http://github.com/jcmagalhaes/pullall'
end