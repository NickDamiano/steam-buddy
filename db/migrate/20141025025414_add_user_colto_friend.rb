class AddUserColtoFriend < ActiveRecord::Migration
  def change
    change_table :friends do |t|
      t.belongs_to  :user
    end
  end
end
