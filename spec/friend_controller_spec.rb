RSpec.describe FriendController do 
  describe 'get_friends_from_controller' do 
    it 'should get a list of friends ids from controller' do 
      VCR.use_cassette('get_friends_shared') do
        user = '76561197973955570'

        hash = FriendRepo.get_friends(user)

        # expect(hash[:success?]).to be true
        # expect(hash[:friends]).to include("76561197995163285")
      end
    end
  end
end