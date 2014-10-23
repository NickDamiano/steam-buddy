class SaveUser
  def self.checkDb(steam_id_64)
    user = User.find_by(steam_id_64: steam_id_64)
    if user.nil?
      return {:success? => false, :error => "User not found in database"}
    elsif !user.nil?
      return {:success? => true, :result => user}
    end
  end

  def self.parse_cdata_value(cdata_string)
    /\!\[CDATA\[(.*?)\]\]/.match(cdata_string)[1].strip!
  end

  def self.save(user, user_parsed_data)
    #user = User.find_by(steam_id_64: @user_id)
    user.steam_id_64 = user_parsed_data["profile"]["steamID64"]
    unparsed_id = user_parsed_data["profile"]["steamID"]
    user.steam_id = parse_cdata_value(unparsed_id)
    unparsed_avatar = user_parsed_data["profile"]["avatarIcon"]
    user.avatar_icon = parse_cdata_value(unparsed_avatar)
    if user_parsed_data["profile"]["vacBanned"].to_i > 0
      user.vac_banned = true
    else
      user.vac_banned = false
    end
    unparsed_custom_url = user_parsed_data["profile"]["customURL"]
    user.custom_url = parse_cdata_value(unparsed_custom_url)
    user.member_since = user_parsed_data["profile"]["memberSince"]
    location = user_parsed_data["profile"]["location"]
    user.location = parse_cdata_value(location)
    realname = user_parsed_data["profile"]["realname"]
    user.real_name = parse_cdata_value(realname)
    if user_parsed_data["profile"]["groups"]
      user.primary_group_id = user_parsed_data["profile"]["groups"]['group'].first["groupID64"]
      user.primary_group_name = parse_cdata_value(user_parsed_data["profile"]["groups"]['group'].first["groupName"])
    end
    user.save
    if user.id == nil
      return {:success? => false, :error => 'Failed to save user'}
    elsif user.id != nil
      return {:success? => true, :result => user}
    end
  end
end