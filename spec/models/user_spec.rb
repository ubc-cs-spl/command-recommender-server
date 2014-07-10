require 'spec_helper'

describe User, :type => :model do
  context 'Valid User' do
    before{@user = FactoryGirl.build(:user)}
    it{expect(@user).to be_valid}
    specify{
      expect(@user.save).to eq(true)
      saved_user = User.find(@user.id)
      expect(saved_user).to eq(@user)
    }
  end

  context 'Invalid User' do
    before :each do
      @user = FactoryGirl.build(:user)
    end

    context 'Missing User ID' do
      before{@user.user_id = ""}
      it{expect(@user.valid?).to eq(false)}
      specify{expect(@user.save).to eq(false)}
    end


    context 'Duplicate user_id' do
      before{
        @user.save
        @user2 = FactoryGirl.build(:user)
      }
      it{expect(@user2.valid?).to eq(false)}
      it{expect(@user2.save).to eq(false)}
    end

    context 'Missing Date' do
      before{@user.last_upload_date = nil}
      it{expect(@user.valid?).to eq(false)}
      it{expect(@user.save).to eq(false)}
    end
  end
end
