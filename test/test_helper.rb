require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'rubygems'
require 'bundler/setup'


Bundler.require(:default)
require_relative '../config/application'

# Format test output
Minitest::Reporters.use!(
  Minitest::Reporters::SpecReporter.new,
  ENV,
  Minitest.backtrace_filter
)
