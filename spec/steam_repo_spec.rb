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
      name = "yauihsdfauihsdfhuiasdfhu"
      hash = SteamRepo.get_user_summary(name)
      expect(hash[:success?]).to be false
      expect(hash[:error]).to eq("The specified profile could not be found.")
    end

    it "should return a hash when the user is private" do
      name = "blitzcat"
      hash = SteamRepo.get_user_summary(name)
      expect(hash[:success?]).to be false
      expect(hash[:error]).to eq("The specified profile is private.")
    end
  end

  describe ".get_user_games" do
  end  
end