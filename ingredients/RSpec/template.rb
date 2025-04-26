puts "DEBUG: Starting template execution"
puts "DEBUG: Current directory: #{Dir.pwd}"
puts "DEBUG: Environment variables:"
puts "DEBUG: BUNDLE_APP_CONFIG: #{ENV['BUNDLE_APP_CONFIG']}"
puts "DEBUG: BUNDLE_CONFIG: #{ENV['BUNDLE_CONFIG']}"
puts "DEBUG: BUNDLE_WITHOUT: #{ENV['BUNDLE_WITHOUT']}"
puts "DEBUG: BUNDLE_IGNORE_CONFIG: #{ENV['BUNDLE_IGNORE_CONFIG']}"
puts "DEBUG: BUNDLE_USER_HOME: #{ENV['BUNDLE_USER_HOME']}"
puts "DEBUG: GEM_HOME: #{ENV['GEM_HOME']}"
puts "DEBUG: GEM_PATH: #{ENV['GEM_PATH']}"
puts "DEBUG: PATH: #{ENV['PATH']}"

puts "DEBUG: Bundler config before any changes:"
puts `bundle config`

puts "DEBUG: Adding rspec-rails to development/test group"
gem_group :development, :test do
  gem "rspec-rails"
end

puts "DEBUG: Bundler config after adding gem:"
puts `bundle config`

puts "DEBUG: Running bundle install with debug output"
run "bundle install --verbose"

puts "DEBUG: Bundler config after bundle install:"
puts `bundle config`

puts "DEBUG: Generating rspec:install"
generate "rspec:install"

puts "DEBUG: Removing test directory"
run "rm -rf test"

puts "DEBUG: Template execution completed"