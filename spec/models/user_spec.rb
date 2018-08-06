require 'rails_helper'

describe User do
  describe 'validations' do
    let (:user) { create :user }

    it 'has valid factory' do
      expect(user).to be_valid
    end

    describe '.username' do
      it 'must be a string' do
        user.username = 1234567
        expect(user.username.class).to eq(String)
        user.username = []
        expect(user.username.class).to eq(String)
        user.username = {}
        expect(user.username.class).to eq(String)
        user.username = '1234567'
        expect(user.username.class).to eq(String)
      end

      it "can't be nil" do
        user.username = nil
        expect(user).to_not be_valid
      end

      it "can't be blank" do
        user.username = ''
        expect(user).to_not be_valid
      end

      it 'must be unique' do
        user
        user2 = build(:user, email: 'bob@mhw.io')
        expect(user2).to_not be_valid
      end

      it 'length must be between 3 and 20 characters' do
        user.username = 'ro'
        expect(user).to_not be_valid
        user.username = 'robertocarlosmontoyas'
        expect(user).to_not be_valid
        user.username = 'rob'
        expect(user).to be_valid
        user.username = 'robertocarlosmontoya'
        expect(user).to be_valid
      end
    end

    describe '.email' do
      it 'must be a string' do
        user.email = 1234567
        expect(user.email.class).to eq(String)
        user.email = []
        expect(user.email.class).to eq(String)
        user.email = {}
        expect(user.email.class).to eq(String)
        user.email = 'astring@mhw.io'
        expect(user.email.class).to eq(String)
      end

      it "can't be nil" do
        user.email = nil
        expect(user).to_not be_valid
      end

      it "can't be blank" do
        user.email = ''
        expect(user).to_not be_valid
      end
    end

    describe '.password' do
      it "can't be nil" do
        user2 = build(:user, password: nil)
        expect(user2).to_not be_valid
      end

      it "can't be empty" do
        user.password = ''
        expect(user).to_not be_valid
      end

      it 'length must be between 6 and 30 characters' do
        user.password = 'secre'
        expect(user).to_not be_valid
        user.password = 'xextremlytoolongsecretpasswordx'
        expect(user).to_not be_valid
        user.password = 'secret'
        expect(user).to be_valid
        user.password = 'goodextremlylongsecretpassword'
        expect(user).to be_valid
      end
    end

    describe '.hunts_joined' do
      let (:hunt) { create :hunt, leader: user }

      it "can't include a hunt where the user is the leader" do
        user.hunts_joined << hunt
        expect(user).to_not be_valid
      end
    end
  end
end
