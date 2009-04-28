require 'rubygems'
require 'thor'
require 'tempfile'

$:.unshift File.dirname(__FILE__)

require 'sous_chef/cli'
require 'sous_chef/strategy'
require 'sous_chef/strategies/ssh'
