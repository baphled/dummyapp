ENV['RACK_ENV'] = 'test'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'mongoid'
require 'rspec'
require 'quik_cv_models'
require "faker"
require 'factory_girl'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}
Dir["#{File.dirname(__FILE__)}/factories/*.rb"].each {|f| require f}

RSpec.configure do |config|
  Mongoid.load!(File.join(File.dirname(__FILE__), '..', 'config', 'mongoid.yml'))

  config.before :each do
    Mongoid.master.collections.select {|c| c.name !~ /system/ }.each(&:drop)
    DB.recreate! rescue nil
  end
end

Mongoid.configure do |c| 
  c.logger = nil 
end 
