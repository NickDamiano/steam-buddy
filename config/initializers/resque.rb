Dir["/app/app/jobs/*.rb"].each { |file| require file }
rails_root = ENV['RAILS_ROOT'] || File.dirname(__FILE__) + '/../..'
rails_env = ENV['RAILS_ENV'] || 'development'
resque_config = YAML.load_file(rails_root + '/config/resque.yml')
Resque.redis = resque_config[rails_env]
Resque.logger = Logger.new(Rails.root.join('log', "#{rails_env}_resque.log"))