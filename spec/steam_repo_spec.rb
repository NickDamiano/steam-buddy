RSpec.describe SteamRepo do
  # let(:user_name) {}
  describe ".get_user_summary" do
    it "should get a user's XML file from Steam API converted into a hash" do
      name = "youda"
      hash = SteamRepo.get_user_summary(name)
      expect(hash[:success?]).to be true
      expect(hash[:profile]).to_not be_nil
    end
    it "should return a hash when the user is not found" do
      name = "yauihsdfauihsdf98237498234dhjsafdafhuiasdfhu"
      hash = SteamRepo.get_user_summary(name)
      expect(hash[:success?]).to be false
      expect(hash[:error]).to eq("The specified profile could not be found.")
    end

    it "should return a hash when user enters invalid name (invalid url)" do
      name = "    "
      hash = SteamRepo.get_user_summary(name)
      expect(hash[:success?]).to be false
      expect(hash[:error]).to eq("Invalid Steam name")
    end

    it "should return a hash when the user is private" do
      name = "blitzcat"
      hash = SteamRepo.get_user_summary(name)
      expect(hash[:success?]).to be false
      expect(hash[:error]).to eq("The specified profile is private.")
    end
  end

  describe ".get_user_games" do
    it "should return a hash with success true and a list of games the user has" do
      id = "76561197995163285"
      response = SteamRepo.get_user_games(id)
      expect(response[:success?]).to be true
      expect(response[:games]).to be_an(Array)
      expect(response[:games].size).to be > 200
      expect(response[:games].size).to be < 300
    end

    it "shoud return a hash with success false and an error message for invalid id" do
      id = "7324247324792364283472378423423949"
      response = SteamRepo.get_user_games(id)
      expect(response[:success?]).to be false
      expect(response[:error]).to eq("Internal Server Error")
    end
  end

  describe '.get_games_descriptions' do
    it "should return a hash with success true and an array of all the games" do 
      games = [10,20,30,40,50,60,70,130,80,100,220,240,280,300,320,340,360,380,400,420,500]
      length = games.length
      response = SteamRepo.get_games_descriptions(games)
      expect(response[:success?]).to be true
      expect(response[:games].length).to eq(length)
    end
  end
end