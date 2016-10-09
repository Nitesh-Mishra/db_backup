Gem::Specification.new do |s|
  s.name        = 'dbbackups3'
  s.version     = '0.1.0'
  s.date        = '2016-10-06'
  s.summary     = "This gem helps you to easily create backups of the MYSQL Database and save it to the local system or on AWS S3."
  s.authors     = ["Nitesh Mishra"]
  s.email       = 'nitesh.mishra143@gmail.com'
  s.files       = ["lib/dbbackups3.rb"]
  s.homepage    = 'http://rubygems.org/gems/dbbackups3'
  s.license     = 'MIT'
  s.add_dependency 'aws-s3', '~> 0.6.3'
end
