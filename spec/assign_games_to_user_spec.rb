RSpec.describe AssignGamesToUser do
  before(:each) do
    User.delete_all
    Game.delete_all
    Usergame.delete_all
  end

  describe '.run' do
    it 'takes a list of game ids to assign to a user and assigns if not already assigned' do
      games_not_assigned = [0,1]
      game2 = Game.create(steam_appid: 0)
      game3 = Game.create(steam_appid: 1)
      user = User.create
      user_game = user.games.create(steam_appid: 2)
      result = AssignGamesToUser.run(games_not_assigned, user)
      expect(result[:success?]).to be true
    end
  end
end