require          'rubygems'
require          'bundler/setup'
Bundler.require(:default)

require_relative '../sys/builder'

# load core service requirements
require_relative '../lib/namespace.rb'
require_relative '../app/services/base.rb'
require_relative '../app/services/compose.rb'

# load all services
Dir['app/services/**/*.rb'].each do |path|
  puts path
  require_relative "../#{path}"
end
