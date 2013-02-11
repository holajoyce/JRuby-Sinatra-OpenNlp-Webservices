# we can try using the free service REDIS TO GO
#uri = URI.parse(ENV["REDISTOGO_URL"]) 
  
# but instead, we'll use our  owninstalled redis instance 
Resque.redis = Redis.new(:host => 'localhost', :port => 6379) #typical redis port

# load job code from jobs dir
Dir["#{Rails.root}/app/jobs/*.rb"].each { |file| require file }

