Trinidad.configure do |config|
	config.port = 3389 #typical trinidad port
	config.reload_strategy =  "rolling"
	config.jruby_min_runtimes=1
	config.jruby_max_runtimes=1
	#config.address = '0.0.0.0'
  	#config[:custom] = 'custom'
end
