RSpec.describe SaveUser do 
  describe '.save_user' do 


    it 'should find an existing user in the db' do 
      User.create(steam_id_64: 123)
      #takes the userid and searches
      hash = SaveUser.checkDb(123)
      expect(hash[:success?]).to be true
      expect(hash[:result][:steam_id_64]).to eq(123)
    end

    it 'should return an error if user not found' do 
      hash = SaveUser.checkDb(3434343434)
      expect(hash[:success?]).to be false
      expect(hash[:error]).to eq("User not found in database")
    end

    it 'should save a new user into the database' do
      user_to_save = User.new
      new_info = {:profile=>{
        'groups' => {
          'group' => [{}

          ]
        }
        }
      }
      new_info[:profile]['steamID64']        = 76561197995163285
      new_info[:profile]['steamID']          = "goat[yusef]"
      new_info[:profile]['avatarIcon']       = 'http://cdn.akamai.steamstatic.com/steamcommunity/public/images/avatars/de/de0447b6d0b23d766f804e0923706a8642b5fc3d.jpg'
      new_info[:profile]['vacBanned']         = 1
      new_info[:profile]['customURL']          = 'youda'
      new_info[:profile]['memberSince']      = "December 24, 2007"
      new_info[:profile]['location']         = 'Austin, Texas, United States'
      new_info[:profile]['realname']          = 'Yusef'
      new_info[:profile]["groups"]['group'].first["groupID64"] = 103582791434636960
      new_info[:profile]["groups"]['group'].first["groupName"] = 'Steam Family Sharing'

      hash = SaveUser.save(user_to_save, new_info)
      expect(hash[:success?]).to be true
      expect(hash[:result].id).to_not be(nil)
    end


    it 'should update existing user in the database' do
      # user_to_save = User.find_by()
      user_to_save = User.new
      new_info = {:profile=>{
        'groups' => {
          'group' => [{}

          ]
        }
        }
      }
      new_info[:profile]['steamID64']        = 76561197995163285
      new_info[:profile]['steamID']          = "goat[yusef]"
      new_info[:profile]['avatarIcon']       = 'http://cdn.akamai.steamstatic.com/steamcommunity/public/images/avatars/de/de0447b6d0b23d766f804e0923706a8642b5fc3d.jpg'
      new_info[:profile]['vacBanned']         = 1
      new_info[:profile]['customURL']          = 'youda'
      new_info[:profile]['memberSince']      = "December 24, 2007"
      new_info[:profile]['location']         = 'Austin, Texas, United States'
      new_info[:profile]['realname']          = 'Yusef'
      new_info[:profile]["groups"]['group'].first["groupID64"] = 103582791434636960
      new_info[:profile]["groups"]['group'].first["groupName"] = 'Steam Family Sharing'

      hash = SaveUser.save(user_to_save, new_info)
      expect(hash[:success?]).to be true
      expect(hash[:result].id).to_not be(nil)

      new_info[:profile]['steamID64']        = 321
      new_info[:profile]['steamID']          = "goat[yusef] the cs hacker"
      new_info[:profile]['avatarIcon']       = 'http://cdn.akamai.steamstatic.com/steamcommunity/public/images/avatars/de/de0447b6d0b23d766f804e0923706a8642b5fc3d.jpg'
      new_info[:profile]['vacBanned']         = 1
      new_info[:profile]['customURL']          = 'youda'
      new_info[:profile]['memberSince']      = "December 24, 2007"
      new_info[:profile]['location']         = 'Austin, Texas, United States'
      new_info[:profile]['realname']          = 'Yusef'
      new_info[:profile]["groups"]['group'].first["groupID64"] = 103582791434636960
      new_info[:profile]["groups"]['group'].first["groupName"] = 'Steam Family Sharing'

      old_user = User.find_by(steam_id_64: 76561197995163285)

      hash = SaveUser.save(old_user, new_info)
      expect(hash[:success?]).to be true
      expect(hash[:result].id).to_not be(nil)
      expect(hash[:result].steam_id_64).to eq(321)
    end
  end
end

  #looks in database for user
  #sets