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
      id = 76561197995163285
      response = SteamRepo.get_user_games(id)
      expect(response[:success?]).to be true
      expect(response[:games]).to be_an(Array)
      expect(response[:games].size).to be > 200
      expect(response[:games].size).to be < 300
    end
  end

  describe '.get_games_descriptions' do

  end
end