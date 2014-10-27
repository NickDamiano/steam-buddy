require File.expand_path('../boot', __FILE__)
require './lib/repos/steam_repo.rb'
require './lib/repos/friend_repo.rb'
require './lib/txs/save_user.rb'
require './lib/txs/assign_games_to_user.rb'
require './lib/txs/find_new_games.rb'
require './lib/txs/get_games_not_assigned.rb'
require './lib/txs/save_games.rb'
require './lib/txs/update_playtimes.rb'
require './lib/txs/multiplayer_filter.rb'
require './lib/txs/find_genres.rb'
require './lib/txs/genres_filter.rb'
require './lib/txs/friends_filter.rb'
require './lib/txs/played_filter.rb'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SteamGamePicker
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
  end
end
