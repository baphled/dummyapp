require 'mongoid'
require 'validates_timeliness'

LOCALE_PATH = File.expand_path(File.dirname(__FILE__) + '/../config/locales/validates_timeliness.en.yml')
I18n.load_path.unshift(LOCALE_PATH)

Dir[File.join(File.dirname(__FILE__), 'validators', '**', '*.rb')].each {|f| require f}
Dir[File.join(File.dirname(__FILE__), 'quik_cv', '**', '*.rb')].each {|f| require f}

