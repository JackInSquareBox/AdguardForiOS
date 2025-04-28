source "https://rubygems.org"

gem 'fastlane', '2.225.0'

plugins_path = File.join(File.dirname(__FILE__), 'fastlane', 'Pluginfile')
eval_gemfile(plugins_path) if File.exist?(plugins_path)

# Required for Ruby 3.4+ compatibility until Fastlane includes them
gem "abbrev"
gem "mutex_m"
gem "ostruct"