RSpec.describe GetGamesNotAssigned do
  before(:each) do
    User.delete_all
    Game.delete_all
    Usergame.delete_all
  end

  describe '.run' do
    it 'should get a list of games that the user has but not assigned to' do
      # this is the users complete list of games
      users_games = [10,20,30]
      user = User.create
      user.games.create(steam_appid: 10)
      result = GetGamesNotAssigned.run(user, users_games)
      expect(result[:success?]).to be true
      expect(result[:games].size).to eq(2)
    end
  end
end