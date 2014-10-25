RSpec.describe SteamRepo do
  # let(:user_name) {}
  describe ".get_user_summary" do
    xit "should get a user's XML file from Steam API converted into a hash" do
      VCR.use_cassette('user_summary_youda') do
        name = "youda"
        hash = SteamRepo.get_user_summary(name)
        expect(hash[:success?]).to be true
        expect(hash[:profile]).to_not be_nil
      end
    end
    xit "should return a hash when the user is not found" do
      VCR.use_cassette('user_summary_invalid') do
      name = "yauihsdfauihsdf98237498234dhjsafdafhuiasdfhu"
      hash = SteamRepo.get_user_summary(name)
      expect(hash[:success?]).to be false
      expect(hash[:error]).to eq("The specified profile could not be found.")
    end
    end

    xit "should return a hash when user enters invalid name (invalid url)" do
      VCR.use_cassette('user_summary_invalid_url') do
      name = "    "
      hash = SteamRepo.get_user_summary(name)
      expect(hash[:success?]).to be false
      expect(hash[:error]).to eq("Invalid Steam name")
    end
    end

    xit "should return a hash when the user is private" do
      VCR.use_cassette('user_summary_private') do
      name = "blitzcat"
      hash = SteamRepo.get_user_summary(name)
      expect(hash[:success?]).to be false
      expect(hash[:error]).to eq("The specified profile is private.")
    end
    end
  end

  describe ".get_user_games" do
    it "should return a hash with success true and a list of games the user has" do
      VCR.use_cassette('get_user_games_youda') do
        id = "76561197995163285"
        response = SteamRepo.get_user_games(id)

        expect(response[:success?]).to be true
        expect(response[:games]).to be_an(Array)
        expect(response[:games].size).to be > 200
        expect(response[:games].size).to be < 300
      end
    end

    xit "shoud return a hash with success false and an error message for invalid id" do
      VCR.use_cassette('get_user_games_invalid') do
        id = "7324247324792364283472378423423949"
        response = SteamRepo.get_user_games(id)
        expect(response[:success?]).to be false
        expect(response[:error]).to eq("Internal Server Error")
      end
    end
  end

  describe '.get_games_descriptions' do
    xit "should return a hash with success true and an array of all the games" do 
      VCR.use_cassette('get_games_descriptions') do
        games = [3920, 240, 4000, 2620, 2630, 2640, 320, 340, 400, 12900, 2700, 20, 50, 70, 130, 220, 280, 360, 380, 420, 20900, 12210, 18500, 17470, 24740, 1250, 35420, 36000, 24800, 10180, 10190, 23490, 32440, 550, 223530, 24960, 8190, 35140, 33900, 33930, 219540, 17410, 70300, 18400, 21130, 21000, 4540, 44320, 620, 45760, 105600, 20920, 7600, 6000, 6020, 6030, 6060, 32350, 32370, 32380, 32390, 32400, 32420, 32430, 32470, 32500, 8980, 107310, 28050, 63000, 8930, 113200, 55230, 115100, 102600, 72850, 22380, 115110, 207650, 207490, 208600, 3900, 3990, 8800, 16810, 34440, 34450, 34460, 212680, 108800, 3830, 48000, 57300, 204060, 107100, 26800, 40800, 209830, 12750, 730, 202170, 204120, 213330, 215510, 207890, 20820, 41500, 107200, 107800, 108500, 65300, 49520, 204300, 200260, 209540, 206440, 220780, 202970, 202990, 212910, 200710, 204360, 18450, 18460, 18420, 205100, 205790, 214560, 219640, 232210, 219150, 223220, 218740, 4920, 201790, 4560, 9340, 20540, 43110, 50620, 55110, 228200, 214510, 80300, 4570, 113020, 200900, 35720, 212480, 227300, 219890, 218230, 218170, 230980, 224580, 225260, 218060, 203160, 221380, 227080, 233450, 220160, 233720, 3910, 224760, 233230, 234190, 220200, 222730, 235820, 209160, 209170, 236090, 231160, 242920, 242110, 201420, 237530, 214770, 247370, 244070, 239030, 242550, 231040, 218620, 47790, 47830, 209000, 206420, 214550, 253690, 3370, 3390, 3480, 3600, 78000, 3540, 3590, 3620, 221910, 254440, 244090, 267530, 7670, 8850, 8870, 224480, 265930, 285160, 219740, 35450, 236830, 301520, 241930, 107410]
        length = games.length
        response = SteamRepo.get_games_descriptions(games)
        expect(response[:success?]).to be true
        expect(response[:games].length).to eq(length)
      end
    end
  end
end