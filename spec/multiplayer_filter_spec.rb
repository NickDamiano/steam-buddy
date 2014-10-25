RSpec.describe MultiplayerFilter do
  describe '.run' do
    it 'returns a hash with success true and returns all multiplayer games if input is "1"' do
      user = User.create
      user.games.create(multiplayer: true)
      user.games.create(multiplayer: true)
      user.games.create(multiplayer: false)

      result = MultiplayerFilter.run(user, "1")
      expect(result[:success?]).to be true
      expect(result[:pool].size).to eq(2)
    end
  end
end