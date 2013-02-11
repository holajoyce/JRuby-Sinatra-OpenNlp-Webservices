# Disable Rake-environment-task framework detection by uncommenting/setting to false
# Warbler.framework_detection = false

# Warbler web application assembly configuration file
Warbler::Config.new do |config|
	config.dirs = %w(app config tmp lib)
	config.includes = FileList["init.rb"]
	config.jar_name = "tag"
	config.gems += ["sinatra", "haml"]
	config.gems += ["jruby-openssl","activerecord-jdbcmysql-adapter"]
	config.gems -= ["rails"]
	config.gem_dependencies = true
end
