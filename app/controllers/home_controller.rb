require 'open-uri'

class HomeController < ApplicationController
  def index
  end

  def main
    @user_name = params[:user]
    user_hash = SteamRepo.get_user_summary(@user_name)
    if !user_hash[:success?]
      # this will display error somewhere
    end
    response = SaveUser.run(user_hash)
    if !response[:success]
      # error, user not saved
    end

    redirect_to "/games/#{response["user"].steam_id_64}"
  end
end
