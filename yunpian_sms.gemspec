$:.push File.expand_path("../lib", __FILE__)

require 'yunpian_sms/version'

Gem::Specification.new do |s|
  s.name        = 'yunpian_sms'
  s.version     = YunPianSMS::VERSION
  s.date        = '2019-04-04'
  s.summary     = "Yunpian sms ruby sdk"
  s.description = "An unofficial simple yunpian sms ruby gem"
  s.authors     = ["LCola"]
  s.email       = 'james.wang.z81@gmail.com'
  s.files       = %w(README.md LICENSE.md ) + Dir.glob('lib/**/*.rb')
  s.test_files  = Dir.glob('spec/*_spec.rb')
  s.homepage    = 'https://github.com/jameswangz/yunpian_sms'
  s.license     = 'MIT'

  s.add_development_dependency "rspec"

end
