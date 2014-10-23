require 'open-uri'

class HomeController < ApplicationController
  def index
  end

  def main
    @user_name = params[:user]
    user_hash = SteamRepo.get_user_summary(@user_name)
    if !user_hash[:success?]
      #error
      #redirect
    end
    db_check = SaveUser.checkDb(user_hash["profile"]["steamID64"])
    user_to_save = ""
    if db_check[:success?]
      user_to_save = db_check[:result]
    else
      user_to_save = User.new
    end
    save_result = SaveUser.save(user_to_save, user_hash)

    redirect_to "/games/#{save_result[:result].steam_id_64}"
  end
end
