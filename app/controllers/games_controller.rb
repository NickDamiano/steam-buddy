require 'open-uri'
class GamesController < ApplicationController

  def get_users_games_data
    user = User.find_by(steam_id_64: params[:id])
    games_response = SteamRepo.get_user_games(user.steam_id_64)
    if !games_response[:success?]
      # display some error
    end
    descriptions_response = SteamRepo.get_games_descriptions(games_response[:games])
    if !descriptions_response[:success?]
      # error
    end
    new_games = FindNewGames.run(descriptions_response)
    SaveGames.run(new_games)
    to_be_assigned = GetGamesNotAssigned.run(user, games_response[:games])
    AssignGamesToUser(to_be_assigned, user)
    api_list = build_api_call(users_games_list, user)
    get_and_save(api_list, user)
    get_new_games(users_games_list, user)
    render :json => user
  end

end