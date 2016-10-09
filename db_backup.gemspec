Gem::Specification.new do |s|
  s.name        = 'db_back_up'
  s.version     = '0.1.1'
  s.date        = '2016-08-06'
  s.summary     = "This gem helps you to easily create backups of the MYSQL Database and save it to the either local system or on amazon S3."
  s.authors     = ["Nitesh Mishra"]
  s.email       = 'nitesh.mishra143@gmail.com'
  s.files       = ["lib/db_backup.rb"]
  s.homepage    = 'http://rubygems.org/gems/db_back_up'
  s.license     = 'MIT'
  s.add_dependency 'aws-s3', '~> 0.6.3'
end
