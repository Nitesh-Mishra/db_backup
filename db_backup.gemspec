Gem::Specification.new do |s|
  s.name        = 'db_backup'
  s.version     = '0.1.0'
  s.date        = '2016-08-06'
  s.summary     = "Backup of MYSQL Database"
  s.authors     = ["Nitesh Mishra"]
  s.email       = 'nitesh.mishra143@gmail.com'
  s.files       = ["lib/db_backup.rb"]
  s.homepage    = 'http://rubygems.org/gems/db_backup'
  s.license       = 'MIT'
  s.add_dependency 'aws-s3', '~> 0.6.3'
end
