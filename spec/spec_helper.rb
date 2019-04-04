$:.unshift(File.join(File.dirname(__FILE__),'..','lib'))

require 'rubygems'
require 'bundler'
require 'yunpian_sms'

# Bundler.require(:default, :development)

def fixture_path(name)
  File.join(File.dirname(__FILE__), 'fixtures', name.to_s)
end
