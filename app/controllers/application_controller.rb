require_relative '../../lib/repos/steam_repo.rb'
require_relative '../../lib/txs/save_user.rb'
require_relative '../../lib/txs/assign_games_to_user.rb'
require_relative '../../lib/txs/find_new_games.rb'
require_relative '../../lib/txs/get_games_not_assigned.rb'
require_relative '../../lib/txs/save_games.rb'


class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
