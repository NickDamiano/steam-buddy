require 'open-uri'
class GamesController < ApplicationController

  def get_users_games_data
    user = User.find_by(steam_id_64: params[:id])
    games_response = SteamRepo.get_user_games(user.steam_id_64)
    if !games_response[:success?]
      # display some error
    end
    new_games = FindNewGames.run(games_response[:games])
    descriptions_response = SteamRepo.get_games_descriptions(new_games[:games])
    if !descriptions_response[:success?]
      # error
    end
    SaveGames.run(descriptions_response[:games], descriptions_response[:steam_appids])
    to_be_assigned = GetGamesNotAssigned.run(user, games_response[:games])
    AssignGamesToUser.run(to_be_assigned[:games], user)
    UpdatePlaytimes.run(user, games_response[:games], games_response[:playtimes])
    render :json => user
  end

end