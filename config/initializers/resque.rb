Dir["/app/app/jobs/*.rb"].each { |file| require file }
Resque.redis = Redis.new(:url => 'redis://localhost:6379/')