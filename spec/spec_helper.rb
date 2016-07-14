require 'rspec'
require 'byebug'
require 'simplecov'
SimpleCov.start do
  add_filter "/spec/"
end

Dir["./lib/*"].each {|file| require file }
