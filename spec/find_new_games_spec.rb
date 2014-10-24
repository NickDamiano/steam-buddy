RSpec.describe FindNewGames do
  before(:each) do
    User.delete_all
    Game.delete_all
    Usergame.delete_all
  end

  describe '.run' do
    it 'should find the games which are not in the db, return hash' do
      arr =[0,1,2]
      Game.create(steam_appid: 0)
      Game.create(steam_appid: 1)
      Game.new(steam_appid: 2)
      response = FindNewGames.run(arr)
      expect(response[:success?]).to be true
      expect(response[:games].size).to eq(1) 
      expect(response[:games].first).to eq(2)
    end
  end
end