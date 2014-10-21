require 'open-uri'
class GamesController < ApplicationController

  def get_users_games_data(id)
    users_games_list = GameHelper.get_users_games_list(id)
    # check if game id exists in database
    # if not, create api call and then save in database

    # build a list of games which need to call api
    api_list = GameHelper.build_api_call(users_games_list)
  end
end