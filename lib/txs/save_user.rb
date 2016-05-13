class SaveUser
  def self.checkDb(steam_id_64)
    user = User.find_by(steam_id_64: steam_id_64)
    if user.nil?
      return {:success? => false, :error => "User not found in database"}
    elsif !user.nil?
      return {:success? => true, :result => user}
    end
  end

  def self.save(user, user_parsed_data)
    user.steam_id_64 = user_parsed_data[:profile]["steamID64"]
    user.steam_id = user_parsed_data[:profile]["steamID"]
    user.avatar_icon = user_parsed_data[:profile]["avatarIcon"]
    if user_parsed_data[:profile]["vacBanned"].to_i > 0
      user.vac_banned = true
    else
      user.vac_banned = false
    end
    user.custom_url = user_parsed_data[:profile]["customURL"]
    user.member_since = user_parsed_data[:profile]["memberSince"]
    user.location = user_parsed_data[:profile]["location"]
    user.real_name = user_parsed_data[:profile]["realname"]
    # if user_parsed_data[:profile]["groups"]
    #   user.primary_group_id = user_parsed_data[:profile]["groups"]['group'].first["groupID64"]
    #   user.primary_group_name = user_parsed_data[:profile]["groups"]['group'].first["groupName"]
    # end
    user.save
    if user.id == nil
      return {:success? => false, :error => 'Failed to save user'}
    elsif user.id != nil
      return {:success? => true, :result => user}
    end
  end
end