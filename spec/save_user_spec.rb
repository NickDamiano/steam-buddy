RSpec.describe SaveUser do 
  describe '.save_user' do 
    it 'should find an existing user in the db' do 
      User.create(steam_id_64: 123)
      #takes the userid and searches
      hash = SaveUser.checkDb(123)
      expect(hash[:success?]).to be true
      expect(hash[:result][:steam_id_64]).to eq(123)
    end
  end
end

  #looks in database for user
  #sets